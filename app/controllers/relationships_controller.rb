
class RelationshipsController < ApplicationController
  def index
    @relationships = current_account.relationships || current_account.build_relationships
    @all_other_accounts = []
    Account.all.each do |account|
      @all_other_accounts << account unless account == current_account
    end

    @current_account = current_account
    @all_other_accounts
  end

  def create
    @account = Account.find(params[:relationship][:followed_id])
    current_account.follow!(@account)
    redirect_to relationships_path
  end

  def destroy
    @account = Relationship.find(params[:id]).followed
    current_user.unfollow!(@account)
    redirect_to relationships_path
  end


end
