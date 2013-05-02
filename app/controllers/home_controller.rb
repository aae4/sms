class HomeController < ApplicationController
  respond_to :html, :js

  def index
    @services = Service.all
  end

  def generate_api_key
    api_key = ApiKey.find(current_service.api_key.id)
    begin
      token = SecureRandom.hex
    end while ApiKey.exists?(token: token)
    api_key.update_attributes(:token => token)
    @token = token
    render action: :generateApiKey
  end
end
