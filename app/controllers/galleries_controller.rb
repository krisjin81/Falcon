
class GalleriesController < InheritedResources::Base
  before_filter :authenticate_account!
  
  def index
    @home_galleries = Picture.all
  end
end
