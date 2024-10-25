# frozen_string_literal: true

module Api
  extend ActiveSupport::Concern

  INTERNAL_SERVER_ERROR = 500
  RESOURCE_NOT_FOUND = 404

  included do
    rescue_from StandardError, with: :internal_error
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_error_response
  end

  def render_error(message)
    render json: {
      success: false,
      error: message
    }
  end

  def internal_error(exception)
    render json: { message: exception.message,
                   code: INTERNAL_SERVER_ERROR },
           status: :internal_server_error
  end

  def not_found_error_response(exception)
    model = exception.model
    render json: { message: "#{ model } is inactive or not exist!",
                   code: RESOURCE_NOT_FOUND },
           status: :not_found
  end
end
