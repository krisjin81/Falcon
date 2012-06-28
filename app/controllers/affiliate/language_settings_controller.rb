class Affiliate::LanguageSettingsController < ApplicationController
  before_filter :authenticate_affiliate!

  respond_to :html
  responders :flash

  def edit
    @language_settings = current_affiliate.language_settings || current_affiliate.build_language_settings
    respond_with(@language_settings)
  end

  def update
    @language_settings = current_affiliate.language_settings || current_affiliate.build_language_settings
    @language_settings.update_attributes(params[:language_settings])
    respond_with(@language_settings, :location => edit_affiliate_language_settings_path)
  end
end
