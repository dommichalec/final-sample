class MicropostsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  before_action :require_correct_user, only: :destroy

  # create a micropost in memory using the object.build method
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Posted!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost successfully deleted"
    redirect_to request.referrer || root_url
  end

  private

  # should only be allowed to manipulate the content through the web
  def micropost_params
    params.require(:micropost).permit(:content)
  end

  def require_correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
