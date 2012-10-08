class BlogpostsController < InheritedResources::Base

  def index
    @blogposts = current_account.blogposts || current_account.build_blogposts
  end

  def create
    @blogpost = current_account.blogposts.build(params[:blogpost])
    if @blogpost.save
      flash[:success] = "Blog Post created!"
    end
      redirect_to account_profile_path
  end
end
