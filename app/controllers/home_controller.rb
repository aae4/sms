# encoding: utf-8
class HomeController < ApplicationController
  respond_to :html, :js
  before_filter :authenticate_service!, :only => [:generate_api_key]
  before_filter :is_admin?, :only => [:admin_statistics]

  def index
    @services = Service.all
  end

  def admin_statistics
    services = Service.all
    messages_n = Message.count
    #How much in persents each user sends at all
    @data = services.map{|s| [s.email, (s.messages.count.to_f/messages_n).round(3)]}
    #How mych each user sends messages by month
    @monthly_chart_data = []
    services.each do |s|
      byMonths = []
      1.upto(12){|i| byMonths<<s.messagesByMonth(i)}
      @monthly_chart_data << {name: s.email, data: byMonths}
    end
    @monthly_chart_data = @monthly_chart_data.to_json
    #
  end

  def generate_api_key
    if current_service.api_key.blank?
      api_key = ApiKey.create!
      current_service.api_key = api_key
      token = api_key.token
    else
      api_key = ApiKey.find(current_service.api_key.id)
      begin
        token = SecureRandom.hex
      end while ApiKey.exists?(token: token)
      api_key.update_attributes(:token => token)
    end
    @token = token
    render action: :generateApiKey
  end

  private
    def is_admin?
      if !current_service.try(:admin?)
        redirect_to home_path, notice: 'Acces Denied.'
      end
    end
end
