module ApplicationHelper
  # Renders flash :notice and :error messages.
  #
  def show_messages
    "jQuery('#messages').replaceWith('#{escape_javascript(render('layouts/messages'))}');".html_safe
  end

  # Generate html markup for Facebook login button.
  #
  # @param text [String] button text.
  # @param options [Hash] additional options.
  #
  # @return [String] html markup.
  #
  def fb_login_button(text, options = {})
    link_to(text, account_omniauth_authorize_path(:facebook), { 'class' => 'fb-login', 'data-scope' => OAUTH_CONFIG['facebook']['options']['scope'] }.merge(options))
  end

  # Generate html markup for Twitter login button.
  #
  # @param text [String] button text.
  # @param options [Hash] additional options.
  #
  # @return [String] html markup.
  #
  def twitter_login_button(text, options = {})
    link_to(text, account_omniauth_authorize_path(:twitter), { 'class' => 'twitter-login' }.merge(options))
  end
end
