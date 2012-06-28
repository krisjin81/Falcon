class Admin::AdminsController < Admin::BaseController
  inherit_resources
  navigation_section :admins
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
    @query = Admin.search(params[:q])
    if params[:sort_name] and params[:sort_dir]
      @query.build_sort(:name => params[:sort_name], :dir => params[:sort_dir])
    end
  end

  def filter_password
    if params[:admin] and params[:admin][:password].blank? and params[:admin][:password_confirmation].blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end
  end

  def init_associations(resource)
    resource.build_admin_profile unless resource.admin_profile
    resource
  end
end