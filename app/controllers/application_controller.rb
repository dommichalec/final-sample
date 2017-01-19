class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # include SessionsHelper for use of session-related methods across various controllers
  include ApplicationHelper
  include SessionsHelper

  def require_login
    unless logged_in?
      store_location
      flash[:danger] = "Please log in first!"
      redirect_to login_url
    end
  end

end
