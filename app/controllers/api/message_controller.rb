class Api::MessageController < ApplicationController
  #before_filter :authenticate_service!#, :except => [:show, :index]
  before_filter :restrict_access
  # GET /messages
  # GET /messages.json
  respond_to :json, :xml
  def index
    messages = Message.all
    respond_with messages
  end

  def all
    messages = Message.all
    respond_with messages
  end

end
