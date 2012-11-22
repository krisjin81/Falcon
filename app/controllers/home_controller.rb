class HomeController < ApplicationController
  def index
    @latest_pictures = Picture.latest
    @public_showcases = most_popular_showcases
  end

  def showcase_by_filter
    @filter = params[:filter]

    if @filter == 'updated_at'
        showcases = most_recent_showcases
    elsif @filter == 'favorited'
        showcases = most_favorites_showcases        
    elsif @filter == 'unlisted' 
        if account_signed_in?
          showcases = most_unlisted_showcases  
        else
          showcases = most_popular_showcases
        end
    else
        showcases = most_popular_showcases
    end 
      render :partial => "showcase", :showcases => showcases, :filter => @filter 
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
        if showcase.publicly_visible == 1
            showcases << showcase           
        end         
      end
      showcases
   end

   def most_popular_showcases
      showcases = Array.new
      @showcases = Showcase.find(:all, :order => 'id ASC', :conditions => { :publicly_visible => '1' }).each do |showcase|
        if showcase.publicly_visible == 1
            showcases << showcase
        end         
      end
      showcases
   end
  
   def most_unlisted_showcases
      showcases = Array.new
      @showcases = Showcase.find(:all, :order => 'updated_at ASC', :conditions => { :publicly_visible => '0' } ).each do |showcase|
          if user_signed_in? && showcase.publicly_visible== 0
              if showcase.has_invitee?(current_account)
                showcases << showcase
              end 
          end 
      end
      showcases
   end
    
   def most_favorites_showcases
     showcases = Array.new
      @showcases = Showcase.find(:all, :conditions => { :publicly_visible => '1' }, :order => 'cover_picture_id ASC').each do |showcase|
        
        if showcase.publicly_visible== 1
          showcases << showcase          
        end
        
      end
      showcases
   end
end
