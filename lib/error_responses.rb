module ErrorResponses
  def render_unauthorized(errors = nil)
    @api_errors = errors
    render "api/v1/unauthorized", status: 401
  end

  def render_error(errors = nil)
    @api_errors = errors || ""
    render "api/v1/error", status: 400
  end

  def render_unprocessable
    @api_errors = get_resource.errors
    render "api/v1/unprocessable", status: 422
  end

  def render_no_content
    render json: "", status: :no_content
  end
end
