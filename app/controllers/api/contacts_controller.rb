class Api::ContactsController < ApplicationController
  #before_filter :authenticate_service!#, :except => [:show, :index]
  before_filter :restrict_access
  # GET /messages
  # GET /messages.json
  respond_to :json, :xml

  def all
    contacts = User.all
    respond_with contacts
  end

end
