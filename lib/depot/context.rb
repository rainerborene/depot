require "active_support/core_ext/hash"

module Depot
  class Context
    attr_reader :klass, :base

    def initialize(klass, base)
      @klass = klass
      @base = base
    end

    def finder(criteria)
      @finder = criteria
    end

    def create(attributes = {})
      # remove method reference symbol
      key = attributes[:as]
      attributes.except! :as

      # alternate syntax to define attributes
      if block_given?
        klass_instance = @klass.new
        yield klass_instance
        attributes = klass_instance.attributes
      end

      # finder criteria
      criteria = @finder || attributes.keys.first

      # okey, let's do it
      entry = @klass.send("find_or_create_by_#{criteria}", attributes)
      @base.entries[key] = entry if key
      entry
    end
  end
end
