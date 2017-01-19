class MicropostsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  # create a micropost in memory using the object.build method
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Posted!"
      redirect_to user_path(current_user)
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

  # should only be allowed to manipulate the content through the web
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
