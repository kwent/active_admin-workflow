source "https://rubygems.org"

# Declare your gem's dependencies in active_admin_workflow.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'jquery-rails'
end

group :development, :test do
  gem 'pry'
end

gem 'rails'
gem "sqlite3", '~> 1.3.6'
gem 'cancan'
gem 'workflow-activerecord', '>= 4.1', '< 6.0'
