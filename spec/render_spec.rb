# encoding: utf-8
require 'spec_helper'

describe Handlebars::TemplateHandler do

  before do
    @lookup_context = mock('ActionView::LookupContext', :prefixes => [:one])
    @assigns = {:name => 'World'}
    @view = mock('ActionView::Base', :lookup_context => @lookup_context, :assigns => @assigns)
  end

  it 'should be able to render a basic HTML template' do
    render_template('basic_html', '<h1>Hello</h1>').should eql '<h1>Hello</h1>'
  end

  it 'renders handlebars templates' do
    render_template('hbs_html', '<h1>Hello {{name}}</h1>').should eql '<h1>Hello World</h1>'
  end

  describe 'an embedded handlebars partial' do
    before do
      @lookup_context.stub(:find).with("hbs", [:one], true) {mock(:source => "{{name}}", :handler => Handlebars::TemplateHandler)}
    end

    it 'renders' do
      render_template('hbs_partial', '<h1>Hello {{>hbs}}</h1>').should eql '<h1>Hello World</h1>'
    end
  end

  describe 'an embedded erb partial' do
    before do
      @lookup_context.stub(:find).with("erb", [:one], true) {mock(:source => "<%= @name %>", :handler => mock(:ERB))}
      @view.stub(:render).with(hash_including(:partial => 'erb')) {|options| options[:locals][:name]}
    end
    it 'renders' do
      render_template('erb_partial', '<h1>Hello {{>erb}}</h1>').should eql '<h1>Hello World</h1>'
    end
  end

  def render_template(name, source)
    template = Template.new(name, source)
    compiled_template_source = Handlebars::TemplateHandler.call(template)
    @view.instance_eval(compiled_template_source)
  end
end
