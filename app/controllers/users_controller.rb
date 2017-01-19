# rails g controller Users index show new create edit update destroy
class UsersController < ApplicationController
  # before filters
  before_action :set_user, except: [:index, :new, :create]
  before_action :require_login, only: [:edit, :update, :destroy]
  before_action :require_correct_user, only: [:edit, :update]
  before_action :require_admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find_by(id: params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
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
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
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

  # should only be able to manipulate first_name, last_name, email, and password digest
  # through the web
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                   :password_confirmation)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def require_correct_user
    @user = User.find_by(id: params[:id])
    redirect_to root_url unless current_user?(@user)
  end

  def require_admin_user
    unless current_user.admin?
      redirect_to(root_url)
      flash[:danger] = "You do not have authorization to take that action."
    end
  end
end
