require "bundler"
Bundler.setup(:default, :development)
Bundler.require

require "depot"

class User
  attr_accessor :name, :email

  def attributes
    { :name => name, :email => email }
  end
end

Dir["spec/support/**/*.rb"].each {|file| require file}
