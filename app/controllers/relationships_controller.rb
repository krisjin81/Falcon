
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

end
