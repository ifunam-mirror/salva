# Edit this Gemfile to bundle your application"s dependencies.
source :rubygems

gem "rails", "~> 3.2.2"
gem "haml", "3.1.4"
gem "show_for", "0.2.4"
gem "simple_form", "~> 1.5.2"
gem "compass", "~> 0.12.1"
gem "barista", "~> 1.2.1"

# Authorization
gem "cancan", "1.6.7"

# Authentication
gem "devise", "~> 2.1.0"
gem "devise-encryptable", "~> 0.1.1"
gem "devise_ldap_authenticatable", "~> 0.6.0"
gem "net-ldap", "0.2.2"

# Searching and tagging
gem "tsearch", :require => "texticle"
gem "scope_by_fuzzy"

# Control version
gem "simple-navigation", "3.7.0"
gem "paper_trail", "~> 2.6.2"
gem "diff", "~> 0.3.6"

# Misc
gem "carrierwave", "0.5.8"
gem "rmagick", "2.13.1"
#gem "kaminari", "~> 0.13.0"
gem "kaminari"
gem "attribute_normalizer", "~> 1.0.0"
gem "inherited_resources", "~> 1.3.1"
gem "pg", "0.13.2"
gem "meta_search", "~> 1.1.3"
gem "squeel", "~> 0.9.5"

# Rails 3.1 - Asset Pipeline
gem "sass", "~> 3.1.15"
gem "json", "~> 1.6.5"
gem "coffee-script", "~> 2.2.0"
gem "uglifier", "~> 1.2.3"
gem "css_image_embedder", "~> 0.2.0"
gem "sass-rails", "~> 3.2.5"
gem "compass-rails31", "~> 0.12.0.alpha.0.91a748a"

gem "move_associations", "0.0.5"
gem "by_star", "~> 2.0.0.beta1"
gem "tzinfo", "0.3.29"

gem "SystemTimer", "1.2.3", :platforms => :ruby_18
gem "redis", "2.2.2"
gem "redis-namespace", "1.0.2"
gem "resque", "1.20.0"
gem "resque-status", "0.3.2", :require => "resque/status"
gem "resque_mailer", "2.0.3"

gem "prawn", "0.12.0"
gem "prawn_rails", "~> 0.0.7"
gem "spreadsheet", "~> 0.6.8"
gem "barby", "0.5.0"
gem "rest-client", "~> 1.6.7"
gem "RedCloth", "~> 4.2.9"
gem "rtf", "~> 0.3.3"
gem "rtf_rails", "0.0.1"

# Rails Admin
gem "fastercsv", "~> 1.5.4", :platforms => :ruby_18
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'

group :production do
  gem "rack-ssl-enforcer", "0.2.4", :require => "rack/ssl-enforcer"
  gem "capistrano", "~> 2.11.2"
  gem "execjs", "~> 1.3.0"
  gem "therubyracer", "~> 0.9.10"
  gem "exception_notification", "~> 2.5.2"
  gem "octopi", "~> 0.4.5"
  gem "dalli", "~> 1.1.5"
  # gem "newrelic_rpm" , "~> 3.3.0"
end

group :assets do
  gem "compass-rails31", "~> 0.12.0.alpha.0.91a748a"
  gem "coffee-rails", "~> 3.2.2"
  gem "uglifier", "~> 1.2.3"
  gem "css_image_embedder", "~> 0.2.0"
  gem "therubyracer", "~> 0.9.10"
  gem "sass-rails", "~> 3.2.5"
end

group :development do
  gem "rails3-generators", "0.17.4", :require => "rails/generators"
  gem "hpricot", "0.8.4"
  gem "ruby_parser", "2.0.6"
  gem "unicorn", "3.6.0"
#  gem "jquery-rails", "1.0.17"
  gem "jquery-rails"
  gem "capistrano", "~> 2.11.2"
end

group :test do
  gem "rspec-rails", "~> 2.7.0"
  gem "machinist", ">= 2.0.0.beta2"
  gem "forgery", "~> 0.5.0"
  gem "remarkable", ">= 4.0.0.alpha4"
  gem "remarkable_activemodel", ">= 4.0.0.alpha4"
  gem "remarkable_activerecord", ">= 4.0.0.alpha4"
  gem "steak", "~> 2.0.0"
end

