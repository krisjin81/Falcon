module Admin::LayoutHelper

  # Gets title for admin area.
  #
  def admin_area_title
    "#{I18n.t('application.title')} :: #{I18n.t('application.admin_area')}"
  end

  # Renders navigation item for top admin menu.
  #
  # @param section [Symbol] navigation section appropriate to this item. See Admin::BaseController.navigation_section.
  #                         Uses to determines whether item should be highlighted as active.
  # @param path [String] menu item navigation path.
  #
  # @return [String] html markup.
  #
  def navigation_item(section, path)
    content_tag(:li, link_to(I18n.t("admin.sections.#{section}"), path), :class => (section == @navigation_section) ? 'active' : '')
  end

  # Generates table header with change sort link
  #
  # @param name [String] display name of field.
  # @param attribute [Symbol] field attribute (accepts nested associations delimited with underscore).
  #
  # @return [String] html markup for header.
  #
  # @example
  #
  # sortable_header(Account.human_attribute_name(:email), :email)
  # sortable_header(Profile.human_attribute_name(:first_name), :profile_first_name)
  #
  def sortable_header(name, attribute)
    display_name = name
    asc = params[:sort_dir].blank? || params[:sort_dir] == 'asc'
    if attribute.to_s ==  params[:sort_name]
      display_name = "#{display_name} #{content_tag(:i, nil, :class => asc ? 'icon-arrow-up' : 'icon-arrow-down')}".html_safe
      asc = !asc
    end
    link_to display_name, url_for(:sort_name => attribute, :sort_dir => asc ? 'asc' : 'desc', :q => params[:q], :per_page => params[:per_page])
  end
end