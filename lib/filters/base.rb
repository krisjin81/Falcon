# Filters used to apply some visual effects to uploaded image. To implement custom filter you need to extend
# Filters::Base class and implement #process method with custom image processing operations.
#
module Filters

  # Abstract class for image processing filters. It contains some basic functionality for image processing.
  # Inspired by http://net.tutsplus.com/tutorials/php/create-instagram-filters-with-php/.
  # It uses raw image magick commands cause I have no idea how to implement some operation with RMagick
  # Need to rethink how to optimize it with mini_magick gem.
  #
  class Base
    include Magick

    class << self

      # Adds all inherited classes to subclasses collection.
      #
      # @param subclass [Class] inherited class.
      #
      def inherited(subclass)
         if superclass.respond_to? :inherited
           superclass.inherited(subclass)
         end

         subclass_key = subclass.filter_name
         @subclasses ||= {}
         @subclasses[subclass_key] = subclass
      end

      # Gets subclasses as hash.
      #
      # @return [Hash] subclasses hash where key is a filter semantic name symbol and value is fully qualified class name.
      #
      def subclasses
        @subclasses
      end

      # Gets subclasses as list.
      #
      # @return [Hash] subclasses as list of pair where each pair contains class human name and fully qualified class name.
      #                Use "filters.#{key}" translation keys to localize it.
      #
      def subclasses_list
        @subclasses.to_a.map do |key, value|
          key = I18n.t("filters.#{key}", :default => key.to_s.humanize)
          [key, value]
        end
      end

      # Gets filter semantic name.
      #
      # @return [Symbol] symbolized class name without module path in underscore.
      #
      def filter_name
        name.split("::").last.underscore.to_sym
      end
    end

    # Applies filter to given image. Creates temporary file and place result to it.
    #
    # @param source [String] image file path.
    #
    # @return [String] formatted image file path.
    #
    def apply(source)
      destination = generate_filename(source)
      FileUtils.cp(source, destination)
      image = Image.read(source).first
      @width = image.columns
      @height = image.rows
      image.destroy!
      process(destination)
    end

    # Filter specific processing should be placed here.
    #
    # @param source [String] image file path.
    #
    # @return [String] formatted image file path.
    #
    def process(image)
      raise NotImplementedError.new("Method should be implemented in subclasses")
    end

    protected

    # Generates temporary file path.
    #
    # @param source_file_path [String] source file path.
    # @param postfix [String] temporary postfix to indicate filter in path.
    #
    # @return [String] temporary file path
    #
    def generate_filename(source_file_path, postfix = self.class.filter_name)
      filename = File.basename(source_file_path, '.*')
      extension = File.extname(source_file_path)
      dirname = File.join(Rails.root, "public", "system", "tmp", CarrierWave.generate_cache_id)
      FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
      File.join(dirname, "#{filename}_#{postfix}#{extension}")
    end

    # Changes color tone of image in highlights and/or shadows. For example, we want to change black to purple.
    #
    def colortone(image, color, level, type = 0)
      negate = type == 0 ? '-negate' : ''
      %x{ convert '#{image}' \
          \\( -clone 0 -fill '#{color}' -colorize 100% \\) \
          \\( -clone 0 -colorspace gray #{negate} \\) \
          -compose blend -define compose:args=#{level},#{100 - level} -composite \
          #{image} }
      image
    end

    # Adds border to image.
    #
    def border(image, color = 'black', width = 20)
      %x{ convert #{image} \
          -bordercolor '#{color}' -border #{width}x#{width} \
          #{image} }
      image
    end

    # Composes photo with predefined frame from file.
    #
    def frame(image, frame)
      %x{ convert '#{image}' \
          \\( '#{frame}' -resize #{@width}x#{@height}! -unsharp 1.5x1.0+1.5+0.02 \\) -flatten \
          '#{image}' }
      image
    end

    # Fades out or desaturates edges of photo gradually. We can even reverse this, or use colors for vignette.
    #
    def vignette(image, start_color = 'none', end_color = 'black', crop_factor = 1.5)
      canvas_width = (@width * crop_factor).floor
      canvas_height = (@height * crop_factor).floor

      %x{ convert '#{image}' \
          \\( -size #{canvas_width}x#{canvas_height} radial-gradient:'#{start_color}'-'#{end_color}' -gravity center -crop #{@width}x#{@height}+0+0 +repage \\) \
          -compose multiply -flatten \
          '#{image}' }
      image
    end
  end
end