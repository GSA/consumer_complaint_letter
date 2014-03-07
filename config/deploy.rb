set :bundle_cmd, "/home/cah/.rvm/gems/ruby-2.0.0-p353@global/bin/bundle"
set :bundle_dir, "/home/cah/.rvm/gems/ruby-2.0.0-p353"
require 'bundler/capistrano'
require "rvm/capistrano"
require "rvm/capistrano/alias_and_wrapp"
require 'capistrano/ext/multistage'
require './config/boot'
set :stages, %w(development staging production)
set :default_stage, "development"

#set :bundle_dir, ''
#set :bundle_flags, '--system --quiet'
set :rvm_type, :user                     # Defaults to: :auto
set :rvm_ruby_version, '2.0.0-p353'      # Defaults to: 'default'

set :web_user, nil
set :application, "cah_rails"
set :scm, "git"
set :repository, "git@github.com:mobomo/cah_rails.git"

set :use_sudo, false
set :deploy_via, :remote_cache

before 'deploy:assets:update_asset_mtimes', 'deploy:symlink_files'
after "deploy:restart", "deploy:cleanup"


desc "Shows the date/time and commit revision of when the code was most recently deployed for a server"
task :last_deployed do
  deploy_date = ""
  git_revision = ""
  run("#{sudo :as => web_user if web_user} ls -al #{File.join(current_path, 'REVISION')}", :pty => true) do |channel, stream, data|
    deploy_date = data.to_s.split()[5..-2].to_a.join(" ").to_s
  end
  run("#{sudo :as => web_user if web_user} cat #{File.join(current_path, 'REVISION')}", :pty => true) do |channel, stream, data|
    git_revision = data.to_s.split("\n").last
  end
  puts "Last deployed at: #{deploy_date}"
  puts "Git Revision: #{git_revision}"
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Add config dir to shared folder"
  task :add_shared_config do
    run "mkdir -p #{deploy_to}/shared/config"
  end

  desc "Symlink files"
  task :symlink_files, :roles => :app do
    run "echo \"RUBY_VERSION: $RUBY_VERSION\""
    run "echo \"GEM_HOME: $GEM_HOME\""
    run "echo \"BUNDLE_PATH $BUNDLE_PATH\""
    run "echo \"PATH $PATH\""
    run "rm #{release_path}/config/database.yml"
    run "ln -nfs #{deploy_to}/shared/config/*.yml #{release_path}/config/"
  end
end
