class Account::ProfilesController < ApplicationController
  include Styx::Initializer

  before_filter :authenticate_account!

  respond_to :html
  responders :flash

  def show
    @profile = load_profile
    @profile.build_avatar unless @profile.avatar
    @micropost = @profile.account.microposts.build(params[:micropost])
    styx_initialize_with :profile_id => @profile.unique_id
     if @micropost.save
      flash[:success] = "Micropost created!"
       redirect_to root_url
     end


    #respond_with(@profile)
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

  def load_profile
    if params[:profile_id]
      Profile.by_unique_id(params[:profile_id]).first.tap do |profile|
        raise ActiveRecord::RecordNotFound.new("Could not found profile with username or id '#{params[:profile_id]}'") unless profile
      end
    else
      current_account.profile || current_account.build_profile
    end
  end
end
