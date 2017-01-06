# rails g controller Users index show new create edit update destroy
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :delete, :archive, :unarchive]

  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    # same as @user = User.new(params[:user]), but allows for mass-assignment
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to the sample application, #{@user.first_name}!"
      redirect_to @user # ideomatically correct way of writing user_url(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Your account has been successfully updated!"
      redirect_to user_url(@user)
    else
      render 'edit'
    end
  end

  def destroy
  end

  def archive
    archival_for(@user)
    @user.save
    flash[:warning] = "Your account has been successfully archived."
    redirect_to @user # ideomatically correct way of writing user_url(@user)
  end

  def unarchive
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

  def set_user
    @user = User.find(params[:id])
  end
end
