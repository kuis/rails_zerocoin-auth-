module Api::V1
  class ApiController < ApplicationController
    
    include ErrorResponses

    protect_from_forgery with: :null_session

    before_action :authenticate_user_from_token
    before_action :set_resource, only: [:destroy, :show, :update]

    respond_to :json

    def current_user
      access_token = request.headers["HTTP_AUTHORIZATION"]
      api_key = ApiKey.find_by(access_token: access_token)
      User.find(api_key.user_id) if api_key
    end

    def authenticate_user_from_token
      render_unauthorized unless current_user
    end

    def authenticate_user_from_invite_key
      render_unauthorized unless valid_invite_key? || current_user
    end

    def index
      plural_resource_name = "@#{resource_name.pluralize}"
      resources = resource_class.where(query_params)

      instance_variable_set(plural_resource_name, resources)
      instance_variable_get(plural_resource_name)
    end

    def show
      get_resource
    end

    def create
      set_resource(resource_class.new(resource_params))

      if get_resource.save
        render :create, status: :created
      else
        render_error get_resource.errors
      end
    end

    def update
      if get_resource.update(resource_params)
        render :update
      else
        render_error get_resource.errors
      end
    end

    def destroy
      get_resource.destroy
      head :no_content
    end

    rescue_from(ActionController::ParameterMissing) do |exception|
      error = {}
      error[exception.param] = ["Parameter is required"]
      render_error(error)
    end

    private

    def get_resource
      instance_variable_get("@#{resource_name}")
    end

    def query_params
      {}
    end

    def resource_class
      @resource_class ||= resource_name.classify.constantize
    end

    def resource_name
      @resource_name ||= self.controller_name.singularize
    end

    def resource_params
      self.send("#{resource_name}_params")
    end

    def set_resource(resource = nil)
      resource ||= resource_class.find_by(id: params[:id].to_i)
      render_no_content if resource.blank?
      instance_variable_set("@#{resource_name}", resource)
    end
  end
end
