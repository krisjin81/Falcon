require_relative 'base'

module Filters

  # Named after Lord Kelvin, this effect applies a strong peach/orange overlay, and adds a washed out photo frame.
  #
  class Kelvin < Base

    # In English: create a working file, load the image into memory, normalize, enhance brightness by a fifth,
    # desaturate by half, create an peach/orange color overlay, and apply the multiply blending mode.
    # Lastly, add a frame, using the PNG file.
    #
    def process(image)
      %x{ convert \
          \\( '#{image}' -auto-gamma -modulate 120,50,100 \\) \
          \\( -size #{@width}x#{@height} -fill 'rgba(255,153,0,0.5)' -draw 'rectangle 0,0 #{@width},#{@height}' \\) \
          -compose multiply \
          #{image} }
      image
    end
  end
end