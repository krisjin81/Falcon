require_relative 'base'

module Filters

  # Nashville has a nice washed out 80s fashion photo feel. It produces image with a magenta/peach tint.
  # It additionally adds a frame to get that slide look. It’s easily one of the most popular Instagram filters.
  #
  class Nashville < Base

    # In English: create a working file, load the image into memory, change blacks to indigo,
    # change whites to peach color, enhance contrast, enhance saturation by half, gamma auto-correction.
    # Add a frame from a PNG file.
    #
    def process(image)
      image = colortone(image, '#222b6d', 100, 0)
      image = colortone(image, '#f7daae', 100, 1)
      %x{ convert #{image} \
          -contrast -modulate 100,150,100 -auto-gamma \
          #{image} }
      image
    end
  end
end