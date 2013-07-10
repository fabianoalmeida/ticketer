source 'https://rubygems.org'

gem 'rails', '3.2.9'
gem 'i18n'
gem 'arel'
# Use to integrate with the CAS (Central Authentication Server) server made in Java (JGuard)
gem 'rubycas-client'
#gem 'rubycas-client-rails', :path => "lib/rubycas-client-rails"
gem 'state_machine'
gem 'juggernaut' #, :git => 'https://github.com/maccman/juggernaut.git'

gem "jquery-rails"
gem "htmlentities"
gem "friendly_id"
gem "squeel"

gem "prawn"
gem "prawnto_2", :require => "prawnto"

gem "restfulie"

group :assets do
  gem 'sass-rails', "  ~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier', '>= 1.0.3'
end

group :production do  
  #----------------- Begin configuration for Oracle database ---------------#
  # Prevent loading of ruby-oci8 gem in JRuby
  platforms :ruby do
    gem 'ruby-oci8', "~> 2.1.0"
  end

  # Use either latest oracle_enhanced adapter version from github
  #gem 'activerecord-oracle_enhanced-adapter', '~>1.3.0', :git => 'https://github.com/rsim/oracle-enhanced.git'

  # Or use released gem version
  gem "activerecord-oracle_enhanced-adapter", "~> 1.4.0"

  # optionally also use ruby-plsql
  gem "ruby-plsql", ">=0.4.3"
  #----------------- End configuration for Oracle database ---------------#
end

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
group :development do
  gem 'ruby-debug19'
  gem 'capistrano'
  gem 'sqlite3'
end

group :test do
  #gem 'webrat'
  gem 'rspec-rails', '~> 2.4'
  gem 'autotest'
  gem 'autotest-rails'
  gem 'factory_girl_rails'
  #NOTE to get this work on ubuntu you need to have libnotify binaries installed  sudo apt-get install libnotify-bin
  gem 'autotest-notification'
  gem 'database_cleaner'
end
