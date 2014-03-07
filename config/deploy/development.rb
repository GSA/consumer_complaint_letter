set :user, "cah"
set :deploy_to, "/home/cah/cah_deploy/#{application}"
set :domain, "ec2-54-225-92-235.compute-1.amazonaws.com"
set :rails_env, :production

role :web, "#{domain}"                          # Your HTTP server, Apache/etc
role :app, "#{domain}"                          # This may be the same as your `Web` server
role :db,  "#{domain}", :primary => true        # This is where Rails migrations will run

set :branch, ENV['BRANCH'] || 'master'
