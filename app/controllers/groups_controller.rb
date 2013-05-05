class GroupsController < ApplicationController
  before_filter :authenticate_service!
  
  def index
    @groups = current_service.groups
  end

  def edit
    @group = Group.find(params[:id])
  end
  
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
      else
        render 'new'
      end
    end  
  end

  def update
    @group=Group.find(params[:id])
    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html {redirect_to :action => 'index', notice: 'Group was succesfully updated'}
        format.json {render json: @group, status: :updated, location: @group}
      else
        format.html {rende action: 'edit'}
        format.json {render json: @group.errors, status: :unprocessable_entity}
      end
    end
  end
  
  def show
    @group = Group.find(params[:id])
  end
end
