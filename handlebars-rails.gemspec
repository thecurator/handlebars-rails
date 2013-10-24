lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'handlebars-rails/version'

Gem::Specification.new do |gem|
  gem.version               = Handlebars::Rails::VERSION
  gem.name                  = 'handlebars-rails'
  gem.files                 = `git ls-files`.split("\n")
  gem.summary               = "Rails Template Handler for Handlebars"
  gem.description           = "Use Handlebars.js client- and server-side"
  gem.email                 = "james.a.rosen@gmail.com"
  gem.homepage              = "http://github.com/jamesarosen/handlebars-rails"
  gem.authors               = ["James A. Rosen", "Yehuda Katz", "Charles Lowell"]
  gem.test_files            = []
  gem.require_paths         = [".", "lib"]
  gem.has_rdoc              = 'false'
  current_version           = Gem::Specification::CURRENT_SPECIFICATION_VERSION
  gem.specification_version = 2
  gem.add_runtime_dependency      'rails',        '>= 3.0'
  gem.add_runtime_dependency      'handlebars', '~> 0.5.0'

  gem.add_development_dependency  'rake'
  gem.add_development_dependency  'redgreen',     '~> 1.2'
  gem.add_development_dependency  'rspec',        '~> 2.7'
end
