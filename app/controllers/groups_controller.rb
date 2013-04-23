class GroupsController < ApplicationController
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
  
  def show
    @group = Group.find(params[:id])
  end
end
