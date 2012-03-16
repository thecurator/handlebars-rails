# encoding: utf-8
require 'spec_helper'

describe Handlebars::TemplateHandler do

  def assigns
    @assigns ||= {:name => 'World'}
  end

  it 'should be able to render a basic HTML template' do
    template = Template.new('basic_html', '<h1>Hello</h1>')
    compiled_template_source = Handlebars::TemplateHandler.call(template)
    eval(compiled_template_source).should eql '<h1>Hello</h1>'
  end

  it 'renders handlebars templates' do
    template = Template.new('hbs_html', '<h1>Hello {{name}}</h1>')
    compiled_template_source = Handlebars::TemplateHandler.call(template)
    eval(compiled_template_source).should eql '<h1>Hello World</h1>'
  end
end
