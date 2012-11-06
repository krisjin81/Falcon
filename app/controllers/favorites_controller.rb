# -*- coding: utf-8 -*-
class FavoritesController < ApplicationController
  before_filter :authenticate_account!

  def create
    @favorite = current_account.favorites.build(params[:favorite])
    if @favorite.save
      flash[:success] = "Marked as favorite!"
    end
    redirect_to account_profile_path
  end

end
# {"utf8"=>"✓", "authenticity_token"=>"L2aWWcSZUAuHqi2fbO9uQHCoV+XBYiMCQHpgk/p24eI=", "favorite"=>{"account_id"=>"1"}, "commit"=>"Favorite"}
