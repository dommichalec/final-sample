class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # validates email address strings
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
end
