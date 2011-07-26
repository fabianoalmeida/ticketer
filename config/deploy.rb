set :application, "Ticketer"
set :repository,  "https://github.com/fabianoalmeida/ticketer.git"
#set :repository,  "progoz@10.32.1.30:/var/repos/ticketer.git"

set :scm, :git
set :deploy_to, "/var/www/#{application}"
set :local_repository, "."

set :user , 'ticketer'
#set :use_sudo, false
server "ticketer.hsi.scmba.com.br", :app, :web, :db, :primary => true
default_run_options[:pty] = true
#default_environment["LD_LIBRARY_PATH"] = "/opt/oracle/instantclient_10_2"
#RVM RECIPE
#$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
#require "rvm/capistrano"                  # Load RVM's capistrano plugin.
#set :rvm_bin_path, "$HOME/,bin"
#set :rvm_ruby_string, '1.9.2-p180@ticketer'
#set :rvm_type, :user

#BUNDLE RECIPE
require "bundler/capistrano"

#REDIS RECIPE
set :redis_init_path, "/etc/init.d/redis"
namespace :redis do
  desc "Starting the redis Server"
  task :start, :roles => :app  do
    run "#{try_sudo} #{redis_init_path} start"
  end

  desc "Stoping the redis Server"
  task :stop, :roles => :app  do
    run "#{try_sudo} #{redis_init_path} stop"
  end

  desc "Restarting the redis Server"
  task :restart, :roles => :app  do
    run "#{try_sudo} #{redis_init_path} restart"
  end
end

#JUGGERNAUT RECIPE
namespace :juggernaut do

  desc "Start the juggernaut Server"
  task :start, :roles => :app  do
    run "#{try_sudo} start juggernaut"
  end

  desc "Start the juggernaut Server"
  task :stop , :roles => :app do
    run "#{try_sudo} stop juggernaut"
  end

  desc "Start the juggernaut Server"
  task :restart, :roles => :app  do
    juggernaut.stop
    juggernaut.start
  end
end

#DEPLOY RECIPE
set :nginx_init_path, "/etc/init.d/nginx"
namespace :deploy do
  task :start, :roles => :app do
    run "#{try_sudo}  #{nginx_init_path} start"
    redis.start
    juggernaut.strt
  end

  task :stop, :roles => :app do
    run "#{try_sudo} #{nginx_init_path} stop"
    redis.stop
    juggernaut.stop
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    redis.restart
    juggernaut.restart
  end
end

