class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # use to change any object with a archived attr from unarchived to archived
  def archival_for(object)
    object.archived = true
  end

  # use to change any object with a archived attr from archived to unarchived
  def unarchival_for(object)
    object.archived = false
  end
end
