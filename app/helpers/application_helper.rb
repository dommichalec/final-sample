module ApplicationHelper

  # returns the full title of each page on the page's tab
  def full_title(title="")
    base_title = "Ruby on Rails Tutorial Sample App"
    if title.strip.empty?
      base_title
    else
      title.strip + " | " base_title}
    end
  end
end
