class HomeController < ApplicationController
  def index
    @latest_pictures = Picture.latest
    @showcases = home_page_showcases
  end

  private

  def home_page_showcases
    showcases = Array.new
    @showcases= Showcase.all.each do |showcase|
      if showcase.cover_picture
        if showcase.publicly_visible?
          showcases << showcase
        else
          if user_signed_in?
            showcases << showcase if showcase.has_invitee?(current_account)
          end
        end
      end
    end
    showcases
  end

end
