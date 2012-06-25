class Accounts::ProfilesController < ApplicationController
  before_filter :authenticate_account!

  respond_to :html
  responders :flash

  def edit
    @profile = current_account.profile || current_account.build_profile
    respond_with(@profile)
  end

  def update
    @profile = current_account.profile || current_account.build_profile
    filter_username(@profile, params[:profile])
    @profile.update_attributes(params[:profile])
    respond_with(@profile, :location => edit_accounts_profiles_path)
  end

  private

  def filter_username(profile, attributes = {})
    if profile.username.present?
      attributes.delete(:username)
    end
  end
end