class Accounts::LanguageSettingsController < ApplicationController
  before_filter :authenticate_account!

  respond_to :html
  responders :flash

  def edit
    @language_settings = current_account.language_settings || current_account.build_language_settings
    respond_with(@language_settings)
  end

  def update
    @language_settings = current_account.language_settings || current_account.build_language_settings
    @language_settings.update_attributes(params[:language_settings])
    respond_with(@language_settings, :location => edit_accounts_language_settings_path)
  end
end
