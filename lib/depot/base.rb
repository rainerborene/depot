module Depot
  class Base
    attr_reader :entries, :models
    attr_accessor :logging
   
    def initialize
      @entries = {}
      @logging = false
      @models = Set.new

      if defined?(ActiveRecord)
        subclasses = ActiveRecord::Base.send(:subclasses).map do |m|
          m.name.downcase.pluralize.gsub(/::/, "_").to_sym
        end
        @models.merge(subclasses)
      end
    end

    def logging(value = true)
      @logging = value

      if defined?(ActiveRecord)
        @buffered ||= ActiveRecord::Base.logger
        ActiveRecord::Base.logger = @logging ? Logger.new(STDOUT) : @buffered
      end
    end

    def inject(*args)
      @models.merge args.map(&:to_sym)
    end

    def method_missing(name, &block)
      if @models.include? name and block_given?
        klass = name.to_s.gsub("_", "::").singularize.classify.constantize
        Context.new(klass, self).instance_eval(&block)
      elsif entries.has_key? name
        @entries[name]
      else
        super
      end
    end
  end
end
