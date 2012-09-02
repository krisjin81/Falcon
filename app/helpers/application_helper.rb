module ApplicationHelper
  # Renders flash :notice and :error messages.
  #
  def show_messages
    "$('#messages').replaceWith('#{escape_javascript(render('layouts/messages'))}');".html_safe
  end

  # Clears flash :notice and :error messages.
  #
  def clear_messages
    "$('#messages').empty();".html_safe
  end

  # Renders link with icon.
  #
  # @param text [String] link text.
  # @param icon [String] icon name from bootstrap set.
  # @param path [String] link path.
  # @param options [Hash] additional options for link_to tag.
  #
  # @return [String] html markup.
  #
  def link_to_with_icon(text, icon, path, options = {})
    link_to("#{text} <i class=\"icon-#{icon}\"></i>".html_safe, path, options)
  end

  # Renders link with pencil icon.
  #
  # @param text [String] link text.
  # @param path [String] link path.
  # @param options [Hash] additional options for link_to tag.
  #
  # @return [String] html markup.
  #
  def edit_link_to(text, path, options = {})
    link_to_with_icon(text, "pencil", path, options)
  end

  # Renders text specified or blank string.
  #
  # @param text [String] text to render.
  #
  # @return [String] text or blank string if text is empty.
  #
  def text_or_blank(text)
    text.present? ? text : '<span class="blank">(blank)</span>'.html_safe
  end

  # Renders icon html tag.
  #
  # @param text [String] text to render.
  #
  # @return icon_name [String] bootstrap icon name.
  #
  def icon(icon_name)
    "<i class=\"icon-#{icon_name}\"></i>".html_safe
  end

  # Renders icon html tag with title.
  #
  # @param text [String] text to render.
  # @param title [String] title to render.
  #
  # @return icon_name [String] bootstrap icon name.
  #
  def icon_with_title(icon_name, title)
    "<i class=\"icon-#{icon_name}\"></i> #{title}".html_safe
  end

  # Renders coma separated list of names.
  #
  # @param collection [Enumerable] a list of items.
  #
  # @return [String] coma separated list of names or empty string if some error occurred when extracting names.
  #
  def names_list(collection)
    collection.map(&:name).join(',') rescue ''
  end

  def comments_path(picture)
    if params[:profile_id]

    else

    end
  end
end
