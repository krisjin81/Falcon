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
    if @showcase.account.id != current_account.id
      redirect_to account_profile_path
    end
    @showcase
  end
end
