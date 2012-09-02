class Account::PicturesController < ApplicationController
  before_filter :authenticate_account!

  def index
    @pictures = resources.all
    @likes = Like.liked_by(current_user.profile, @pictures)
    @likes_count = Like.count_on(@pictures)
  end

  def new
    @picture = resources.new
    render :action => 'form'
  end

  def create
    @picture = resources.new
    if @picture.update_attributes(params[:picture])
      @pictures = resources.all
      flash[:notice] = I18n.t('flash.actions.create.notice', :resource_name => resource_name)
      render :action => 'success'
    else
      render :action => 'failure'
    end
  end

  def edit
    @picture = resources.find(params[:id])
    render :action => 'form'
  end

  def update
    @picture = resources.find(params[:id])
    if @picture.update_attributes(params[:picture])
      @pictures = resources.all
      flash[:notice] = I18n.t('flash.actions.update.notice', :resource_name => resource_name)
      render :action => 'success'
    else
      render :action => 'failure'
    end
  end

  def show
    @picture = resources.find(params[:id])
    @like = Like.liked_by(current_user.profile, @picture)
    @likes_count = Like.count_on(@picture)
    render :action => 'show'
  end

  def destroy
    @picture = resources.find(params[:id])
    @picture.destroy
    @pictures = resources.all
    flash[:notice] = I18n.t('flash.actions.destroy.notice', :resource_name => resource_name)
    render :action => 'index'
  end

  def apply_filter
    filter = "Filters::#{params[:filter].camelize}".constantize.new
    path = normalize_path(params[:path])
    path = filter.apply(path)
    uploader = PictureUploader.new
    uploader.store!(File.open(path, 'r'))
    uploader.cache_stored_file!
    @result = { :success => true, :cache_name => uploader.cache_name, :url => uploader.url, :preview_url => uploader.url(:preview) }
  rescue => exc
    @result =  { :success => false, :message => exc.message }
  ensure
    respond_to do |format|
      format.json { render :json => @result }
      format.xml { render :xml => @result }
    end
  end

  def upload
    uploader = PictureUploader.new
    uploader.store!(params[:file])
    uploader.cache_stored_file!
    @result = { :success => true, :cache_name => uploader.cache_name, :url => uploader.url, :preview_url => uploader.url(:preview) }
  rescue => exc
    @result =  { :success => false, :message => exc.message }
  ensure
    respond_to do |format|
      format.json { render :json => @result }
      format.xml { render :xml => @result }
      format.html { render :layout => false }
    end
  end

  private

  def load_profile
    @profile ||= if params[:profile_id]
      Profile.by_unique_id(params[:profile_id]).first.tap do |profile|
        raise ActiveRecord::RecordNotFound.new("Could not found profile with username or id '#{params[:profile_id]}'") unless profile
      end
    else
      current_account.profile || current_account.build_profile
    end
  end

  def resources
    if ["index", "show"].include? params[:action]
      load_profile.pictures
    else
      current_account.profile.pictures
    end
  end

  def current_account_pictures
    current_account.profile.pictures
  end

  def resource_name
    Picture.model_name.human
  end

  def normalize_path(path)
    full_path = File.expand_path(File.join(Rails.root, "public", path))
    raise Exception.new("Permission denied.") unless full_path.start_with?(Rails.root.to_s)
    full_path
  end
end
