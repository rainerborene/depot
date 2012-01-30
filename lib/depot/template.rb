module Depot
  class Template < ActionView::Base
    include Rails.application.routes.url_helpers if defined?(Rails.application.routes)
    include ActionView::Helpers::TagHelper
  end
end
