require "depot/base"
require "depot/context"
require "depot/version"

module Depot
  def self.construct(&block)
    Base.new.tap do |depot|
      depot.instance_eval(&block)
    end
  end
end
