class Api::ContactsController < ApplicationController
  before_filter :restrict_access
  before_filter :get_service_by_api_key

  respond_to :json, :xml

  def all
    contacts = @current_service.users
    respond_with contacts
  end

  def create_contact
    user = User.new
    user.services << @current_service

    user.name = params[:name]
    user.phone = params[:phone]

    if user.save
      respond_with :user_id => user.id, :status => "ok"
    else
      respond_with :error => "Invalid arguments"
    end
  end

  def delete_contact
    user = User.find(params[:id])
    user.destroy
    if params[:id].blank? || user.blank?
      respond_with :error => "Invalid arguments"
    else
      respond_with :status => "ok"
    end
  end

end
