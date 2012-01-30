ENV["RAILS_ENV"] ||= "test"

require "bundler"
Bundler.setup(:default, :development)
require "rails/all"
require "rails/test_help"
Bundler.require

require "depot"

class User
  attr_accessor :name, :email

  def attributes
    { :name => name, :email => email }
  end
end

Dir["spec/support/**/*.rb"].each {|file| require file}
