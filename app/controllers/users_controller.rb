class UsersController < ApplicationController
  before_filter :authenticate_service!
  
  def index
    @users = current_service.users
    respond_to do |format|
      format.html
      format.xml {render xml: @users}
      format.json {render json: @users}
    end
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(params[:user])
    @user.services << current_service
    respond_to do |format|
      if @user.save
        format.html {redirect_to :action => 'index', notice: 'User was succesfully added'}
        format.json {render json: @user, status: :created, location: @user}
      else
        format.html {render action: 'new'}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html {redirect_to :action => 'index', notice: 'User was succesfully updated'}
        format.json {render json: @user, status: :updated, location: @user}
      else
        format.html {rende action: 'edit'}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end
  
  def destroy
    @user=User.find(params[:id])
    @user.destroy
    redirect_to :action => "index"
  end

  def show
    @user = User.find(params[:id])
  end
end
