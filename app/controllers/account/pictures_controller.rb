class Account::PicturesController < ApplicationController
  before_filter :authenticate_account!
  before_filter :set_owner, :only => [:create]

  respond_to :js
  responders :flash

  def new
    respond_with(@picture = Picture.new)
  end

  def create
    @picture = Picture.create(params[:picture])
    @pictures = current_account.profile.pictures if @picture.valid?
    respond_with(@picture)
  end

  def edit
    respond_with(@picture = Picture.find(params[:id]))
  end

  def update
    @picture = Picture.find(params[:id])
    @picture.update_attributes(params[:picture])
    @pictures = current_account.profile.pictures if @picture.valid?
    respond_with(@picture)
  end

  def show
    respond_with(@picture = Picture.find(params[:id]))
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    respond_with(@picture)
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
end
