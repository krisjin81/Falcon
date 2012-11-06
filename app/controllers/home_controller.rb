class HomeController < ApplicationController
  def index
    @latest_pictures = Picture.latest
    @public_showcases = Showcase.all
  end
end
