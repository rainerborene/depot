module Depot
  class Context
    # A constant that is used to trigger the #finder method.
    attr_reader :klass

    # The base attribute references the base instance.
    attr_reader :base

    # Create a new context instance.
    def initialize(klass, base)
      @klass = klass
      @base = base
    end

    # Change the finder criteria.
    def finder(criteria)
      @finder = criteria
    end

    # Render template and return the string.
    #
    #   render_template :post, title: "Hello World"
    #
    # You have the ability to change the directory location, which is used to
    # lookup the template file passing a third argument. Otherwise the
    # +db/seeds+ path will be the default.
    def render_template(template, assigns = {}, view_path = nil)
      view_path ||= Rails.root.join("db", "seeds")
      view = Depot::Template.new(view_path)
      view.assign(assigns)
      view.render :template => template.to_s
    end

    # Create a new entry.
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
