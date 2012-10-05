class MicropostsController < ApplicationController

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to account_profile_path
    end
  end

  def destroy
  end
end
