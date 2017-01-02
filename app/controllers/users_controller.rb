# rails g controller Users index show new create edit update destroy
class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # same as @user = User.new(params[:user]), but allows for mass-assignment
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the sample application, #{@user.first_name}!"
      redirect_to @user # ideomatically correct way of writing user_url(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def archive
    @user = User.find(params[:id])
    archival_for(@user)
    @user.save
    flash[:warning] = "Your account has been successfully archived."
    redirect_to @user # ideomatically correct way of writing user_url(@user)
  end

  def unarchive
    @user = User.find(params[:id])
    unarchival_for(@user)
    @user.save
    flash[:success] = "Welcome back to the sample application, #{@user.first_name}!"
    redirect_to @user # ideomatically correct way of writing user_url(@user)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                   :password_confirmation)
  end
end
