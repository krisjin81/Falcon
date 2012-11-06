class ShowcasesController < InheritedResources::Base
  before_filter :authenticate_account!
  def index
    @showcases = current_account.showcases || current_account.build_showcases
  end

  def create
    @showcase = current_account.showcases.build(params[:showcase])
    params[:showcase][:default] == false unless params[:showcase][:default]
    if @showcase.save
      flash[:success] = "Showcase created!"
    end
    redirect_to account_profile_path
  end

  def show
    @showcase = Showcase.find_by_id(params[:id])

    redirect_to account_profile_path unless ( @showcase.publicly_visible? || (@showcase.publicly_visible? == false && @showcase.has_invitee?(current_account)) || (@showcase.publicly_visible? == false && @showcase.account_id == current_account.id ))

    # display the showcase if
    # 1. Showcase is public
    # 2. Showcase is not public but the user have invitee
    # 3. Showcase is not public but it is the current user's showcase

    @showcase
  end

  def update
    @showcase = Showcase.find_by_id(params[:id])
    params[:showcase][:account_ids] = [] unless params[:showcase][:account_ids]
    @showcase.non_owner_accounts.each do |acc|
      if params[:showcase][:account_ids].include?(acc.id.to_s)
        @showcase.invitees.build(:account_id => acc.id)
      else
        @showcase.invitees.each do |invitee|
          invitee.delete if invitee.account_id == acc.id
        end
      end
    end
     params[:showcase].delete(:account_ids)
    super
  end
end

