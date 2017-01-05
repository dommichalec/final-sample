module ApplicationHelper

  # returns the full title of each page on the page's tab
  def full_title(title="")
    base_title = "Ruby on Rails Tutorial Sample App"
    if title.strip.empty?
      base_title
    else
      title.strip + " | " + base_title
    end
  end

  # use to change any object with a archived attr from unarchived to archived
  def archival_for(object)
    object.archived = true
  end

  # use to change any object with a archived attr from archived to unarchived
  def unarchival_for(object)
    object.archived = false
  end
end
