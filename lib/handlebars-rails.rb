require 'handlebars-rails/version'
require 'handlebars'
require "active_support"

module Handlebars
  class TemplateHandler

    def self.handlebars
      Thread.current[:handlebars_context] ||= Handlebars::Context.new
    end

    def self.call(template)
      %{
        handlebars = ::Handlebars::TemplateHandler.handlebars
        handlebars.compile(#{template.source.inspect}).call(assigns).force_encoding(Encoding.default_external).html_safe
      }
    end
  end
end

ActiveSupport.on_load(:action_view) do
  ActionView::Template.register_template_handler(:hbs, ::Handlebars::TemplateHandler)
end
