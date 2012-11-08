class CommentsController < ApplicationController
  before_filter :authenticate_account!

  inherit_resources

  def create
    @comment = Comment.create(:author => current_account.profile, :body => params[:comment][:body], :created_at => Time.now)
    @commentable  = Blogpost.find_by_id(params[:blogpost_id]) if(params[:blogpost_id])
    @commentable  = Showcase.find_by_id(params[:showcase_id]) if(params[:showcase_id])

    if(@commentable)
      @comment.update_attribute(:commentable, @commentable)
      if @comment.save do |success, failure|
          success.js { render :action => 'create' }
          failure.js { render :action => 'create_failure' }
        end
      end
    end
  end

    protected

    def build_resource
      get_resource_ivar || set_resource_ivar(super.set_author(current_user.profile))
    end
  end
