class Account::PicturesController < ApplicationController
  before_filter :authenticate_account!

  include Magick

  def upload
    if params[:file].present?
      file_name = File.basename(params[:file].original_filename)
      timestamp = Time.now.strftime("%Y%m%d%H%M%S")
      directory = File.join(Rails.root, 'public', 'tmp', timestamp)
      FileUtils.mkdir_p(directory)
      file_path = File.join(directory, file_name)
      File.open(file_path, "wb") { |f| f.write(params[:file].read) }
      @result =  { :success => true, :path => relative_url(file_path), :preview_path => resize(file_path, 200, 200) }
    else
      @result =  { :success => false, :message => "File can not be blank." }
    end

    respond_to do |format|
      format.json { render :json => @result }
      format.xml { render :xml => @result }
    end
  end

  private

  def resize(file_path, width, height)
    image = Image.read(file_path).first
    image.resize_to_fill!(width, height)
    new_file_name = "#{File.basename(file_path, '.*')}_preview#{File.extname(file_path)}"
    new_file_path = File.join(File.dirname(file_path), new_file_name)
    image.write(new_file_path)
    relative_url(new_file_path)
  end

  def relative_url(file_path)
    File.join("/", Pathname.new(file_path).relative_path_from(Pathname.new(File.join(Rails.root, 'public'))))
  end
end
