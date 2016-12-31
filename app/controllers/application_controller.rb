class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def archival_for(object)
    object.archived = true
  end

  def unarchival_for(object)
    object.archived = false
  end
end
