class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource

  helper_method :current_user, :user_signed_in?, :current_user_type

  # Overrides default devise behaviour to provide custom path after admin sign out.
  #
  # @param resource [String] resource name.
  #
  # @return [String] path to redirection after sign out.
  #
  def after_sign_out_path_for(resource)
    if resource.to_sym == :admin
      new_admin_session_path
    else
      super
    end
  end

  protected

  def layout_by_resource
    layouts = [:affiliate, :admin]
    if devise_controller? and layouts.include?(resource_name)
      resource_name.to_s
    elsif user_signed_in? and layouts.include?(current_user_type)
      current_user_type.to_s
    else
      "application"
    end
  end

  # Gets currently logged in account or affiliate.
  #
  # @return [User] account or affiliate.
  #
  def current_user
    User::TYPES.each do |mapping|
      user = self.send("current_#{mapping.to_s.downcase}")
      return user unless user.nil?
    end
  end

  # Determines whether account or affiliate is logged in.
  #
  # @return [Boolean] true if account or affiliate is logged in and false otherwise.
  #
  def user_signed_in?
    !!current_user
  end

  # Gets currently logged in user type (account, affiliate, guest).
  #
  # @return [Symbol] :account, :affiliate or :guest symbol.
  #
  def current_user_type
    User::TYPES.each do |mapping|
      user = send("current_#{mapping.to_s.downcase}")
      return mapping unless user.nil?
    end
    :guest
  end
end
