class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def restrict_access
      @api_key = ApiKey.find_by_token(params[:token])
      head :unathorized unless @api_key
    end

    def get_service_by_api_key
      @current_service = @api_key.service
    end
end
