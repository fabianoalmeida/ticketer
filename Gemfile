source 'http://rubygems.org'

gem 'rails', '3.0.5'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#gem 'mysql2'
gem 'sqlite3'

# Use to integrate with the CAS (Central Authentication Server) server made in Java (JGuard)
gem 'rubycas-client'

#----------------- Begin configuration for Oracle database ---------------#
# Prevent loading of ruby-oci8 gem in JRuby
#platforms :ruby do
#  gem 'ruby-oci8', ">= 2.0.4"
#end

# Use either latest oracle_enhanced adapter version from github
#gem 'activerecord-oracle_enhanced-adapter', '~>1.3.0', :git => 'https://github.com/rsim/oracle-enhanced.git'

# Or use released gem version
# gem "activerecord-oracle_enhanced-adapter", "~>1.3.0"

# optionally also use ruby-plsql
#gem "ruby-plsql", ">=0.4.3"
#----------------- End configuration for Oracle database ---------------#

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  #gem 'webrat'
  gem 'rspec-rails', '~> 2.4'
  gem "autotest"
  gem "autotest-rails"
end
