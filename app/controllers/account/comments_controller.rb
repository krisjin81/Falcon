class Account::CommentsController < ApplicationController
  before_filter :authenticate_account!

  inherit_resources
  belongs_to :picture

  def create
    create! do |success, failure|
      success.js { render :action => 'create' }
      failure.js { render :action => 'create_failure' }
    end
  end

  protected

  def build_resource
    get_resource_ivar || set_resource_ivar(super.set_author(current_user.profile))
  end
end
