class Admin::AffiliatesController < Admin::BaseController
  inherit_resources
  navigation_section :affiliates
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
    init_associations(super)
  end

  private

  def init_search_query
    @query = Affiliate.search(params[:q])
    if params[:sort_name] and params[:sort_dir]
      @query.build_sort(:name => params[:sort_name], :dir => params[:sort_dir])
    end
  end

  def filter_password
    if params[:affiliate] and params[:affiliate][:password].blank? and params[:affiliate][:password_confirmation].blank?
      params[:affiliate].delete(:password)
      params[:affiliate].delete(:password_confirmation)
    end
  end

  def init_associations(resource)
    resource.build_business_profile unless resource.business_profile
    resource.business_profile.build_avatar unless resource.business_profile.avatar
    resource
  end
end