module Depot
  class Base
    # The entries hash stores created objects.
    attr_reader :entries

    # An instance of +Set+ that contains available models as symbols.
    attr_reader :models

    # The logging boolean attribute. It's false by default.
    attr_accessor :logging
   
    # Create a new base instance.
    #
    # If you're using +ActiveRecord+ all subclasses are automatically appended
    # to the #models set. You don't have to worry about injecting them manually.
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

    # Change the +ActiveRecord::Base+ logger output to +STDOUT+ if given value
    # is true.
    def logging(value = true)
      @logging = value
      if defined?(ActiveRecord)
        @buffered ||= ActiveRecord::Base.logger
        ActiveRecord::Base.logger = @logging ? Logger.new(STDOUT) : @buffered
      end
    end

    # Inject new symbols to the #models set. You should pass symbols in the
    # plural form.
    def inject(*args)
      @models.merge args.map(&:to_sym)
    end

    # All magic happens here.
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
