class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include Sprockets::Helpers::RailsHelper

  storage :file

  process :resize_to_fit => [800, 800]

  version :thumb do
    process :resize_and_pad => [100,100]
  end

  version :preview do
    process :resize_and_pad => [200,200]
  end

  def extension_white_list
    %w(jpg jpeg gif png bmp)
  end

  def default_url
     "/200x200.png"
  end

  def store_dir
    if model and model.id
      "system/pictures/#{model.id}"
    else
      File.join(cache_dir, CarrierWave.generate_cache_id)
    end
  end

  def cache_dir
    "system/tmp"
  end

  def filename
    if filename = super
      filename.chomp(File.extname(filename)) + '.png'
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
