class HomeController < ApplicationController
  def index
    @latest_pictures = Picture.latest
    @showcases = home_page_showcases
  end

  def showcase_by_filter
    @filter = params[:filter]

    if @filter == 'updated_at'
        showcases = most_recent_showcases
    elsif @filter == 'favorited'
        showcases = most_favorites_showcases
    else
        showcases = most_popular_showcases
    end

    #logger.info showcases
    render :partial => "showcase", :showcases => showcases
  end

  def picture_by_filter
    @filter = params[:filter]

    if @filter == 'updated_at'
        pictures = most_recent_pictures
    elsif @filter == 'favorited'
        pictures = most_favorites_pictures
    else
        pictures = most_popular_pictures
    end

    #logger.info showcases
    render :partial => "picture", :pictures => pictures
  end

  private
   def most_recent_pictures
     pictures = Array.new
     @pictures = Picture.latest.each do |picture|
       pictures << picture
     end
      pictures
   end

   def most_popular_pictures
     pictures = Array.new
     @pictures = Picture.find(:all, :order => 'title desc').each do |picture|
       pictures << picture
     end
     pictures
   end

   def most_favorites_pictures
     pictures = Array.new
     @pictures = Picture.find(:all, :order => 'title desc').each do |picture|
       pictures << picture
     end
     pictures
   end

   def most_recent_showcases
      showcases = Array.new
      @showcases = Showcase.find(:all, :order => 'updated_at desc').each do |showcase|
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

   def most_popular_showcases
      showcases = Array.new
      @showcases = Showcase.find(:all, :order => 'id ASC').each do |showcase|
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

   def most_favorites_showcases
     showcases = Array.new
      @showcases = Showcase.find(:all, :order => 'cover_picture_id ASC').each do |showcase|
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
>>>>>>> kris_dev
end
