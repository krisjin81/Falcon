namespace :carierwave do
  desc "Removes cached files which are older than one day."
  task :cleanup => :environment do
    CarrierWave.clean_cached_files!
  end

  namespace :pictures do
    desc "Recreates pictures versions."
    task :recreate => :environment do
      Picture.all.each do |picture|
        picture.original_image.recreate_versions!
        picture.formatted_image.recreate_versions!
      end
    end
  end

  namespace :avatars do
    desc "Recreates avatars versions."
    task :recreate => :environment do
      Avatar.all.each do |avatar|
        avatar.image.recreate_versions!
      end
    end
  end
end