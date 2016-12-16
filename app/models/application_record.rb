class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # validates email address strings
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
end
