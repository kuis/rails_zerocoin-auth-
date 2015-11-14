module Api::V1
  class AuthController < ApiController
    include ApipieDescriptions

    skip_before_filter :authenticate_user_from_token,
      only: [:create, :destroy]

    skip_before_action :set_resource,
      only: [:destroy]

    apipie_auth_create
    def create
    ap params
      if authenticate_user?
        find_or_create_api_key
      else
        error = { message: "Invalid Email/Password" }
        render_unauthorized error
      end
    end

    apipie_auth_destroy
    def destroy
      access_token = request.headers["HTTP_AUTHORIZATION"]
      ApiKey.where(access_token: access_token).destroy_all
    end

    private

    def user
      @user ||= User.find_by(email: auth_params[:email].downcase)
    end

    def authenticate_user?
      user && user.valid_password?(auth_params[:password])
    end

    def find_or_create_api_key
      @api_key = ApiKey.where(user: user).first_or_create
      render status: 201
    end

    def resource_class
      "api_key".classify.constantize
    end

    def set_resource(resource = nil)
      resource ||= resource_class.find_by(id: auth_params[:id].to_i)
      instance_variable_set("@#{resource_name}", resource)
    end

    def auth_params
      params.require(:user).permit(:email, :password)
    end
  end
end
