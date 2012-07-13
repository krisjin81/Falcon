require_relative 'base'

module Filters

  # The Toaster filter resembles old Polaroid shots; it features vivid colors with pink/orange glow out of the center.
  # By the words of Instagram CEO, it’s one of the most difficult effects to create; we’ll take his word for it.
  class Toaster < Base

    # In English: create a working file, load the image into memory, change blacks to dark red, enhance brightness,
    # desaturate by a fifth, perform gamma correction (make image brighter), add more contrast, add more contrast, save.
    # Lastly, add a grayish vignette (desaturates edges a bit), and an “inverted” orange vignette for color burn effect.
    #
    def process(image)
      image = colortone(image, '#330000', 100, 0)
      %x{ convert #{image} \
          -modulate 150,80,100 -gamma 1.2 -contrast -contrast \
          #{image} }
      image = vignette(image, 'none', '#CDC1C5')
      image = vignette(image, '#FF9966', 'none')
      border(image, 'white', 20)
    end
  end
end