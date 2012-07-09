class Account::PicturesController < ApplicationController
  before_filter :authenticate_account!
  before_filter :set_owner, :only => [:create]

  def new
    @picture = Picture.new
    render :action => 'form'
  end

  def create
    @picture = Picture.new
    if @picture.update_attributes(params[:picture])
      @pictures = current_account.profile.pictures
      flash.now[:notice] = I18n.t('flash.actions.create.notice', :resource_name => resource_name)
      render :action => 'success'
    else
      render :action => 'failure'
    end
  end

  def edit
    @picture = Picture.find(params[:id])
    render :action => 'form'
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update_attributes(params[:picture])
      @pictures = current_account.profile.pictures
      flash.now[:notice] = I18n.t('flash.actions.update.notice', :resource_name => resource_name)
      render :action => 'success'
    else
      render :action => 'failure'
    end
  end

  def show
    @picture = Picture.find(params[:id])
    render :action => 'show'
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    flash.now[:notice] = I18n.t('flash.actions.destroy.notice', :resource_name => resource_name)
    render :action => 'destroy'
  end

  def upload
    uploader = PictureUploader.new
    uploader.store!(params[:file])
    uploader.cache_stored_file!
    @result = { :success => true, :cache_name => uploader.cache_name, :preview_url => uploader.url(:preview) }
  rescue CarrierWave::UploadError => exc
    @result =  { :success => false, :message => exc.message }
  ensure
    respond_to do |format|
      format.json { render :json => @result }
      format.xml { render :xml => @result }
    end
  end

  private

  def set_owner
    params[:picture].merge!(:attachable => current_user.profile)
  end

  def resource_name
    Picture.model_name.human
  end
end
