require "set"
require "logger"
require "active_support/all"
require "depot/base"
require "depot/template"
require "depot/context"
require "depot/version"

module Depot
  # Create an instance of the base class.
  # 
  #   Depot.construct do
  #     users do
  #       create name: "Jane Doe", email: "jane@doe.com"
  #     end
  #   end
  #
  # That basically calls the +find_or_create_by_name+ method on the User
  # constant.
  # 
  def self.construct(&block)
    Base.new.tap do |depot|
      depot.instance_eval(&block)
    end
  end
end
