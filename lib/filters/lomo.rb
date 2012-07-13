require_relative 'base'

module Filters

  # Lomography is all about making high contrast photos with vignettes and soft focus (everywhere you go).
  # In real life, they are mostly made with Holga, LOMO LC-A or so called toy cameras (cameras with plastic lens).
  # This effect is pretty easy to recreate; we will simply enhance the red and green channels’ contrast by a third,
  # and add a vignette. Feel free to experiment as you wish.
  #
  class Lomo < Base

    # Create a working file, load the image into memory, enhance red channel contrast by a third, enhance red channel
    # again, apply a vignette.
    #
    # Tip: If you prefer lomo effect without vignette, just comment or remove that section of code.
    #
    def process(image)
      %x{ convert #{image} \
          -channel R -level 33% -channel G -level 33% \
          #{image} }
      vignette(image)
    end
  end
end