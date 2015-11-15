module Api::V1
  class UsersController < ApiController
    include ApipieDescriptions

    skip_before_filter :authenticate_user_from_token,
      only: [:create]

    apipie_users_create
    def create
      set_resource(resource_class.new(resource_params))
      if get_resource.save
        create_api_key
        render :create, status: :created
      else
        render_unprocessable
      end
    end

    apipie_users_update
    def update
      result = Braintree::Customer.create(  
        :credit_card => {                   
          :number => params[:credit_card][:card_number],
          :expiration_month => params[:credit_card][:expired_month],        
          :expiration_year => params[:credit_card][:expired_year],       
          :cvv => params[:credit_card][:cvc],                    
          :options => {:verify_card => true}
        }                                   
      )

      if result.success?
        current_user.customer_id = result.customer.id
        current_user.save
        render :update, status: :ok
      elsif result.credit_card_verification
        puts verification.processor_response_code
        puts verification.processor_response_text
      else
        render json: {error: result.errors.full_messages}, status: 401
      end
    end

    def user_params
      params
        .require(:user)
        .permit(
          :email,
          :password,
          :name,
          :verified
         )
    end

    def destroy
      user = User.find(params[:id])
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    end

    private

    def admin_only
      unless current_user.admin?
        redirect_to :back, :alert => "Access denied."
      end
    end

    def secure_params
      params.require(:user).permit(:role)
    end

    def create_api_key
      @api_key = ApiKey.create(user: @user)
    end
  end
end
