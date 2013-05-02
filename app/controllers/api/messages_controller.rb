class Api::MessagesController < ApplicationController
  #before_filter :authenticate_service!#, :except => [:show, :index]
  before_filter :restrict_access
  before_filter :get_service_by_api_key

  respond_to :json, :xml
  def index
    messages = @current_service.messages
    respond_with messages
  end

  def all
    messages = @current_service.messages
    respond_with messages
  end

  def create_message
    message = Message.new
    message.service = @current_service

    body = params[:body]
    user_ids = params[:user_ids] || []
    group_ids = params[:group_ids] || []
    recipients = params[:custom_recipients] || ""

    message.body = body

    user_ids.split(",").each do |id|
      message.users << User.find(id)
    end

    group_ids.split(",").each do |id|
      message.groups << Group.find(id)
    end
    message.custom_recipients = recipients
    
    if message.save
      respond_with :message_id => message.id, :status => "ok"
    else
      respond_with :error => "Invalid arguments"
    end
  end

end
