require_relative 'base'

module Filters

  # The Gotham filter produces a black&white, high contrast image with bluish undertones.
  # In real life, this would be created with a Holga camera and Ilford X2 film.
  #
  class Gotham < Base

    # In English: create a working file, load the image into memory, improve brightness a bit, (almost) desaturate,
    # change the remaining colors to deep purple, gamma correction (value below 1 darkens image), add more contrast,
    # add more contrast, and save everything to a file. Add a 20px black border. Simple, eh?
    #
    def process(image)
      %x{ convert #{image} \
          -modulate 120,10,100 -fill '#222b6d' -colorize 20 -gamma 0.5 -contrast -contrast \
          #{image} }
      image
    end
  end
end