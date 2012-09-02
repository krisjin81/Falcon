class Account::LikesController < ApplicationController
  before_filter :authenticate_account!

  def create
    if Like.track(current_user.profile, picture)
      flash.now[:notice] = I18n.t('account.likes.success')
      @likes_count = Like.count_on(picture)
      render :action => 'create'
    else
      flash.now[:alert] = I18n.t('account.likes.error')
      render :action => 'create_failure'
    end
  end

  protected

  def picture
    @picture ||= Picture.find(params[:picture_id])
  end

  def build_resource
    get_resource_ivar || set_resource_ivar(super.set_author(current_user.profile))
  end
end
