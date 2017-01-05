class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # include SessionsHelper for use of session-related methods across various controllers
  include ApplicationHelper
  include SessionsHelper
end
