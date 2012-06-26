class Affiliates::BusinessProfilesController < ApplicationController
  before_filter :authenticate_affiliate!

  respond_to :html
  responders :flash

  def edit
    @business_profile = current_affiliate.business_profile || current_affiliate.build_business_profile
    @business_profile.build_avatar unless @business_profile.avatar
    respond_with(@business_profile)
  end

  def update
    @business_profile = current_affiliate.business_profile || current_affiliate.build_business_profile
    filter_business_name(@business_profile, params[:business_profile])
    @business_profile.update_attributes(params[:business_profile])
    respond_with(@business_profile, :location => edit_affiliates_business_profiles_path)
  end

  private

  def filter_business_name(business_profile, attributes = {})
    if business_profile.business_name.present?
      attributes.delete(:business_name)
    end
  end
end
