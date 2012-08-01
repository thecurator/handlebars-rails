require 'handlebars-rails/version'
require 'handlebars'
require 'active_support'

module Handlebars
  class TemplateHandler

    def self.handlebars
      @context ||= new_context
    end

    def self.call(template)
      %{
        handler = ::Handlebars::TemplateHandler
        handlebars = handler.handlebars
        handler.with_view(self) do
          handlebars.compile(#{template.source.inspect}).call(assigns).force_encoding(Encoding.default_external).html_safe
        end
      }
    end

    def self.with_view(view)
      original_view = data['view']
      data['view'] = view
      yield
    ensure
      data['view'] = original_view
    end

    def self.new_context
      Handlebars::Context.new.tap do |context|
        context['rails'] = {}
        context.partial_missing do |name|
          name = name.gsub('.', '/')
          lookup_context = data['view'].lookup_context
          partial = lookup_context.find(name, lookup_context.prefixes, true)
          if partial.handler == self
            partial.source
          else
            lambda do |this, context|
              data['view'].render :partial => name, :locals => context
            end
          end
        end
      end
    end

    def self.data
      @context['rails']
    end
  end
end

ActiveSupport.on_load(:action_view) do
  ActionView::Template.register_template_handler(:hbs, ::Handlebars::TemplateHandler)
end
