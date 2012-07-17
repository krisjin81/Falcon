class HomeController < ApplicationController
  def index
    @latest_pictures = Picture.latest
  end
end
