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
        format.html {redirect_to @user, notice: 'User was succesfully added'}
        format.json {render json: @user, status: :created, location: @user}
      else
        format.html {render action: 'new'}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end
  
  def show
  end
end
