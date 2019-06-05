$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_admin/workflow/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_admin_workflow"
  s.version     = ActiveAdmin::Workflow::VERSION
  s.authors     = ["Quentin Rousseau"]
  s.email       = ["contact@quent.in"]
  s.homepage    = "https://github.com/kwent/active_admin_workflow"
  s.summary     = "Provides easy DSL integration between ActiveAdmin & workflow"
  s.description = "Provides easy DSL integration between ActiveAdmin & workflow"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.required_ruby_version = ">= 2.2"

  s.add_dependency "railties", ">= 4.2"
  s.add_dependency "activeadmin", ">= 1.0.0"
  s.add_dependency "workflow", ">= 1.0.0"

  s.add_development_dependency "rake"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "puma"
  s.add_development_dependency "capybara"
  s.add_development_dependency "selenium-webdriver"
  s.add_development_dependency "webdrivers"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_bot_rails"
  s.add_development_dependency "devise"
end
