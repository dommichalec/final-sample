module SessionsHelper
  # signs in the given user.
  def sign_in(user)
    session[:user_id] = user.id
  end

  # returns the :user_id of the session hash back to nil, killing the session
  def sign_out
    # session.delete(:user_id)
    session[:user_id] = nil
    @current_user = nil
  end

  # returns true if there's both a user and that user's pw can be authenticated
  def find_and_authenticate(user)
    user && user.authenticate(params[:session][:password])
  end

  # returns the current user if already present or searches the db and assigns
  # the corresponding record to @user
  # returns nil if no user record found
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # returns true if current_user is assigned, false otherwise
  def logged_in?
    !current_user.nil?
  end
end
