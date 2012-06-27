require 'bundler/capistrano'
require 'capistrano/ext/multistage'

set :stages, %w(staging)

set :application, "Falcon Site"

set :scm, :git
set :repository,  "git@github.com:octofrank/Falcon-V0.1.git"
set :deploy_via, :remote_cache

set :bundle_without, [:development, :test, :heroku]

default_run_options[:pty] = true

desc "Symlink configs."
task :link_configs do
  %w(database cucumber).each do |config_name|
    run "ln -nfs #{release_path}/config/configs/#{config_name}.yml #{release_path}/config/#{config_name}.yml"
  end
end

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after "deploy:finalize_update", :link_configs