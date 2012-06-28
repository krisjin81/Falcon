class Admin::AccountsController < Admin::BaseController
  inherit_resources
  navigation_section :accounts
  paginated

  before_filter :init_search_query
  before_filter :filter_password, :only => [:update]

  protected

  def end_of_association_chain
    @query.result.with_profile
  end

  def build_resource
    init_associations(super)
  end

  def resource
    get_resource_ivar || set_resource_ivar(init_associations(end_of_association_chain.send(method_for_find, params[:id])))
  end

  private

  def init_search_query
    @query = Account.search(params[:q])
    if params[:sort_name] and params[:sort_dir]
      @query.build_sort(:name => params[:sort_name], :dir => params[:sort_dir])
    end
  end

  def filter_password
    if params[:account] and params[:account][:password].blank? and params[:account][:password_confirmation].blank?
      params[:account].delete(:password)
      params[:account].delete(:password_confirmation)
    end
  end

  def init_associations(resource)
    resource.build_profile unless resource.profile
    resource.profile.build_avatar unless resource.profile.avatar
    resource
  end
end