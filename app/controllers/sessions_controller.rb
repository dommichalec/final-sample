class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if find_and_authenticate(user)
      sign_in(user)
      flash[:success] = "Welcome back, #{user.first_name}!"
      redirect_to user_url(user)
    elsif !logged_in?
      flash.now[:danger] = %Q[Hmm... we don't have a user with that email address in our system. <a href= "/signup"> Sign up here</a> to get started.]
      render 'new'
    elsif user && user.authenticate(params[:session][:password]) == false
      flash.now[:danger] = "Hmm... that email/password combination isn't quite right."
      render 'new'
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've signed out. We'll see you again soon!"
    redirect_to root_url
  end
end
