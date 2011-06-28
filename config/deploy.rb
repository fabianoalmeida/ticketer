set :application, "Ticketer"
#set :repository,  "https://github.com/fabianoalmeida/ticketer.git"
set :repository,  "progoz@10.32.1.30:/var/repos/ticketer.git"

set :scm, :git
set :deploy_to, "/var/www/#{application}"

set :user , 'ticketer'
set :use_sudo, false
server "10.30.0.102", :app, :web, :db, :primary => true

#role :web, "10.0.0.3"                          # Your HTTP server, Apache/etc
#role :app, "10.0.0.3"                          # This may be the same as your `Web` server
#role :db,  "10.0.0.3", :primary => true # This is where Rails migrations will run
#role :db,  "10.0.0.3"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

 #If you are using Passenger mod_rails uncomment this:

 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end

$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_bin_path, "$HOME/bin"
set :rvm_ruby_string, '1.9.2@ticketer'
set :rvm_type, :user
require "bundler/capistrano"
#implement recipe for juggernaut 2 
