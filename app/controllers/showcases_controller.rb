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

  def update
    @showcase = Showcase.find_by_id(params[:id])
    params[:showcase][:picture_ids] = [] unless params[:showcase][:picture_ids]
    @showcase.update_attributes(params[:showcase])
    if @showcase.save
      redirect_to showcase_path
    else
      flash[:error] = "Sorry showcase could not be update"
    end
  end

  def show
    @showcase = Showcase.find_by_id(params[:id])
    if @showcase.id != current_account.id
      redirect_to account_profile_path
    end
    @showcase
  end
end
