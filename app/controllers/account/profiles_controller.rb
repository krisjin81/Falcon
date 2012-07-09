class Account::ProfilesController < ApplicationController
  before_filter :authenticate_account!

  respond_to :html
  responders :flash

  def show
    if params[:id]
      @profile = Profile.by_unique_id(params[:id]).first
      raise ActiveRecord::RecordNotFound.new("Could not found profile with username or id '#{params[:id]}'") unless @profile
    else
      @profile = current_account.profile || current_account.build_profile
    end
    @profile.build_avatar unless @profile.avatar
    respond_with(@profile)
  end

  def edit
    @profile = current_account.profile || current_account.build_profile
    @profile.build_avatar unless @profile.avatar
    respond_with(@profile)
  end

  def update
    @profile = current_account.profile || current_account.build_profile
    filter_username(@profile, params[:profile])
    @profile.update_attributes(params[:profile])
    respond_with(@profile, :location => account_profile_path)
  end

  private

  def filter_username(profile, attributes = {})
    if profile.username.present?
      attributes.delete(:username)
    end
  end
end
