set :application, "Ticketer"
set :repository,  "https://github.com/fabianoalmeida/ticketer.git"
#set :repository,  "progoz@10.32.1.30:/var/repos/ticketer.git"

set :scm, :git
set :deploy_to, "/var/www/#{application}"

set :user , 'ticketer'
set :use_sudo, false
server "ticketer.hsi.scmba.com.br", :app, :web, :db, :primary => true

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
set :rvm_ruby_string, '1.9.2-p180@ticketer'
set :rvm_type, :user
require "bundler/capistrano"
#implement recipe for juggernaut 2
