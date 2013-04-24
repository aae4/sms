class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def restrict_access
      api_key = ApiKey.find_by_token(params[:token])
      head :unathorized unless api_key
    end
end
