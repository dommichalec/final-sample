ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  # include ApplicationHelper module to test full_title method
  include ApplicationHelper

  def archival_for(object)
    object.archived = true
  end

  def unarchival_for(object)
    object.archived = false
  end
end
