namespace :configs do
  desc "Symlinks configs (config/<config>.yml -> config/configs/<config>.yml)."
  task :link do
    %w(database oauth).each do |config_name|
      %x{ln -fs #{Rails.root}/config/configs/#{config_name}.yml #{Rails.root}/config/#{config_name}.yml}
    end
  end

  desc "Copies configs (config/<config>.yml -> config/configs/<config>.yml)."
  task :copy do
    %w(database oauth).each do |config_name|
      %x{rm #{Rails.root}/config/#{config_name}.yml}
      %x{cp #{Rails.root}/config/configs/#{config_name}.yml #{Rails.root}/config/#{config_name}.yml}
    end
  end
end