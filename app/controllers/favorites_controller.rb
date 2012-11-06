# -*- coding: utf-8 -*-
class FavoritesController < ApplicationController
  before_filter :authenticate_account!

  def index
    @favorites = current_account.favorites
  end


  def create
    @favorite = Favorite.create
    item = Picture.find_by_id(params[:favorite_picture_id]) if params[:favorite_picture_id]
    item = Showcase.find_by_id(params[:favorite_showcase_id]) if params[:favorite_showcase_id]

    if(item)
      @favorite.update_attribute(:favoritable, item)
      @favorite.account = account
      if @favorite.save
        flash[:success] = "Marked as favorite!"
      end
    end
    redirect_to account_profile_path
  end

  def destroy
    favorite = Favorite.find_by_id(params[:id])
    favorite.delete
    redirect_to account_profile_path
  end


end

# Started POST "/favorites" for 127.0.0.1 at 2012-11-06 15:02:02 +0530
#Processing by FavoritesController#create as HTML
#  Parameters: {"utf8"=>"✓", "authenticity_token"=>"qbvVYVIBU6HqIzRHG/K5OEQUaAE8FlhZ3PGLrSjARmU=", "favorite_account_id"=>"1", "favorite_picture_id"=>"3", "commit"=>"Favorite"}
