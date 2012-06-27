server "falcon", :app, :web, :db, :bg, :primary => true

set :user, "deployer"
set :use_sudo, false

set :branch, "staging"
set :rails_env, "staging"
set :deploy_to, "/var/www/apps/falcon/"
set :keep_releases, 5