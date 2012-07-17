module Account::SocialMediasHelper

  # Generates Facebook share link.
  #
  # @param picture [Picture] picture to share.
  # @param attributes [Hash] link additional html attributes.
  #
  def fb_share_button(picture, attributes = { :class => 'fb-share' })
    attributes.reverse_merge!({
      'data-image' => URI.join(root_url, picture.image.url),
      'data-caption' => t('social_media.facebook_caption'),
      'data-name' => picture.title,
      'data-description' => picture.dressing_tips,
      'data-url' => picture_url(picture)
    })
    link_to image_tag('icons/facebook.png'), '#', attributes
  end

  # Generates Twitter share link.
  #
  # @param picture [Picture] picture to share.
  # @param attributes [Hash] link additional html attributes.
  #
  def twitter_share_button(picture, attributes = { :class => 'twitter-share' })
    options = {
      :url => picture_url(picture),
      :text => t('social_media.tweet_template', :url => picture_url(picture))
    }
    attributes[:target] = '_blank'
    attributes[:title] = t('social_media.share_on_twitter')
    link_to image_tag('icons/twitter.png'), twitter_share_url(options), attributes
  end

  # Generates Pinterest share link.
  #
  # @param picture [Picture] picture to share.
  # @param attributes [Hash] link additional html attributes.
  #
  def pinterest_share_button(picture, attributes = { :class => 'pinterest-share' })
    options = {
      :url => picture_url(picture),
      :media => URI.join(root_url, picture.image.url),
      :description => picture.dressing_tips
    }
    attributes[:target] = '_blank'
    attributes[:title] = t('social_media.share_on_pinterest')
    link_to image_tag('icons/pinterest.png'), pinterest_share_url(options), attributes
  end

  # Generates URL for sharing on Twitter.
  #
  # @param options [Hash] new post details.
  # @option options [String] :url URL to tweet.
  # @option options [String] :text text of tweet.
  #
  def twitter_share_url(options = {})
    "https://twitter.com/share?#{options.to_query}"
  end

  # Generates URL for sharing on Pinterest.
  #
  # @param options [Hash] new post details.
  # @option options [String] :url URL of page to pin.
  # @option options [String] :media URL of image to pin.
  # @option options [String] :description description of page to be pinned.
  #
  def pinterest_share_url(options = {})
    "http://pinterest.com/pin/create/button/?#{options.to_query}"
  end
end
