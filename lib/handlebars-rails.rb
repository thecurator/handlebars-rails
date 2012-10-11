require 'handlebars-rails/version'
require 'handlebars-rails/tilt'
require 'handlebars-rails/template_handler'
require 'handlebars'

module Handlebars
  class Rails < ::Rails::Railtie

    initializer 'handlebars.initialize' do |app|
      ActiveSupport.on_load(:action_view) do
        ActionView::Template.register_template_handler(:hbs, ::Handlebars::TemplateHandler)
      end
      ActiveSupport.on_load(:after_initialize) do
        app.assets.register_engine '.hbs', Handlebars::Tilt
        app.assets.append_path  ::Rails.root.join('app/views')
        app.assets.append_path  ::Rails.root.join('app/templates')
      end
    end
  end
end