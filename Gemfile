source 'http://rubygems.org'

gem 'rails', '3.0.5'

gem 'sqlite3'

gem 'i18n'

# Use to integrate with the CAS (Central Authentication Server) server made in Java (JGuard)
gem 'rubycas-client'
#gem 'rubycas-client-rails', :path => "lib/rubycas-client-rails"

gem 'state_machine'

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


# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
gem 'ruby-debug'

group :development, :test do
  #gem 'webrat'
  gem 'rspec-rails', '~> 2.4'
  gem 'autotest'
  gem 'autotest-rails'
  gem 'factory_girl_rails'
end
