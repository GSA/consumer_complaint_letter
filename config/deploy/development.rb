set :bundle_cmd, "/home/cah/.rvm/gems/ruby-2.0.0-p353@global/bin/bundle"
set :bundle_dir, "/home/cah/.rvm/gems/ruby-2.0.0-p353"
require "rvm/capistrano"
require "rvm/capistrano/alias_and_wrapp"
set :rvm_type, :user                     # Defaults to: :auto
set :rvm_ruby_version, '2.0.0-p353'      # Defaults to: 'default'

set :user, "cah"
set :deploy_to, "/home/cah/cah_deploy/#{application}"
set :domain, "ec2-54-225-92-235.compute-1.amazonaws.com"
set :rails_env, :production

role :web, "#{domain}"                          # Your HTTP server, Apache/etc
role :app, "#{domain}"                          # This may be the same as your `Web` server
role :db,  "#{domain}", :primary => true        # This is where Rails migrations will run

set :branch, ENV['BRANCH'] || 'master'
