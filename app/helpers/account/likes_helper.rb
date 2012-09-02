module Account::LikesHelper
  def likes_dom_id(likeable)
    "likes_#{dom_id(likeable)}"
  end
end
