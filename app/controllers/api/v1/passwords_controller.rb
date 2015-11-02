class Api::V1::PasswordsController < Api::V1::ApiController
  include ApipieDescriptions

  skip_before_filter :authenticate_user_from_token

  respond_to :json

  apipie_passwords_create
  def create
    @user = User.send_reset_password_instructions(params[:user])
    if @user.errors.empty?
      render json: {success: true}, :status => 200
    else
      render :status => :not_found, :json => { :errors => @user.errors.full_messages }
    end
  end
end