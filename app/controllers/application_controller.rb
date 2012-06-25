class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource

  protected

  def layout_by_resource
   if devise_controller? and [:affiliate, :admin].include?(resource_name)
     resource_name.to_s.pluralize
   else
     "application"
   end
  end
end
