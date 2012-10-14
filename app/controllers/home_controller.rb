class HomeController < ApplicationController
  def index
    @latest_pictures = Picture.latest
    @public_showcases = Showcase.find_all_by_publicly_visible(true)
  end
end
