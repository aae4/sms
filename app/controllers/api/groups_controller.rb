class Api::GroupsController < ApplicationController
  before_filter :restrict_access
  before_filter :get_service_by_api_key

  respond_to :json, :xml

  def all
    groups = @current_service.groups
    respond_with groups
  end

  def create_group
    group = Group.new
    group.service = @current_service

    group.name = params[:name]
    user_ids = params[:user_ids] || []

    user_ids.split(",").each do |id|
      group.users << User.find(id)
    end

    if group.save
      respond_with :group_id => group.id, :status => "ok"
    else
      respond_with :error => "Invalid arguments"
    end
  end

  def delete_group
    group = Group.find(params[:id])
    group.destroy
    if params[:id].blank? || group.blank?
      respond_with :error => "Invalid arguments"
    else
      respond_with :status => "ok"
    end
  end



end
