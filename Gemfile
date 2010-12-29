# Edit this Gemfile to bundle your application's dependencies.
source :gemcutter

gem "rails", "3.0.3"
# Views, css and javascript
gem "compass", "0.10.5"
gem "show_for", ">= 0.2.3"
gem "simple_form"

# Authorization
gem "cancan"
# gem "roles_generic"
# gem "roles_active_record"
# gem "cream"

# Authentication
gem "devise", "1.1.3"
gem "devise_ldap_authenticatable"
gem "net-ldap"

# Searching and tagging
gem "tsearch", :require => 'texticle'
gem "scope_by_fuzzy"

# Security
gem "ssl_requirement"

# Control version
gem "vestal_versions"
gem "simple-navigation", "3.0.2"

# Misc
gem "carrierwave", "0.5.0.beta2"
gem "rmagick"
#gem "mongo"
gem "will_paginate", "3.0.pre2"
gem "attribute_normalizer", '1.0.0.pre1'
gem "inherited_resources", "1.1.2"
gem "pg"
gem "meta_search", :git => 'git://github.com/ernie/meta_search.git'
gem "meta_where", '0.9.9.2'
gem "move_associations"
gem "by_star"
gem "tzinfo"
gem "jquery-rails"

gem "SystemTimer", :platforms => :ruby_18
gem 'redis', '2.0.10'
gem "redis-namespace", '0.8.0'
gem "resque", "1.11.0", :git => 'git://github.com/defunkt/resque.git', :require => 'resque'
gem 'resque-status', :require => 'resque/status'
gem "resque_mailer"

gem "prawn", "0.11.1.pre"
gem "spreadsheet"
gem "barby"

group :production do
  gem "inploy"
end

group :development do
  gem "rails3-generators", :require => "rails/generators"
  gem "hpricot"
  gem "ruby_parser"
  gem "unicorn"
  gem "inploy"
end

group :test do
  gem "rspec-rails", ">= 2.0.0.beta.19"
  gem 'machinist', ">= 2.0.0.beta2"
  gem "forgery"
  gem "remarkable", ">= 4.0.0.alpha4"
  gem "remarkable_activemodel"
  gem "remarkable_activerecord", ">= 4.0.0.alpha4"
  gem "remarkable_rails"
  gem 'steak', '>= 1.0.0.beta.1'
  gem 'capybara'
end
