module Account::PicturesHelper

  # Gets picture details page url.
  #
  # @param picture [Picture]
  #
  # @return [String] picture details page URL.
  #
  def picture_url(picture)
    "#{account_view_url(:profile_id => picture.attachable.unique_id)}#!/pictures/#{picture.id}"
  end
end
