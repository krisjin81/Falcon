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
  %w(database oauth).each do |config_name|
    run "ln -nfs #{release_path}/config/configs/#{config_name}.yml #{release_path}/config/#{config_name}.yml"
  end
end

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
      run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end
end

namespace :crontab do
  desc "Update the crontab file"
  task :update, :only => {:primary => true} do
    run "if [[ -d #{current_path} ]]; then cd #{current_path} && RAILS_ENV=#{rails_env} whenever --set environment=#{rails_env} --update-crontab #{application}; fi"
  end

  desc "Clear application's crontab entries using Whenever"
  task :clear, :only => {:primary => true} do
    run "if [[ -d #{current_path} ]]; then cd #{current_path} && RAILS_ENV=#{rails_env} whenever --set environment=#{rails_env} --clear-crontab #{application}; fi"
  end
end

after "deploy:finalize_update", :link_configs
after "deploy:update_code", "crontab:clear" # Disable cron jobs at the beginning of a deployment.
after "deploy:create_symlink", "crontab:update" # Write the new cron jobs near the end.
after "deploy:rollback", "crontab:update" # If anything goes wrong, undo.