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
