module Admin::AdminHelper
  def twitterized_type(type)
    case type
      when :alert
        "alert alert-error"
      when :notice
        "alert alert-success"
      else
        type.to_s
    end
  end

  def admin_menu_class(actual_menu_name)
    menus = {
      :items => ["/admin/items.*", "/admin"],
      :categories => ["/admin/categories.*"],
      :admin => ["/admin/log_book_events", "/admin/admin_users.*"]
    }

    path = request.fullpath.gsub(/\?.*/, "")

    return "active" if menus[actual_menu_name].any? { |e| path =~ /^#{e}$/ }
    return "no-active"
  end

  def render_label(word, palette_name)
    StylePalette::Helper.label(word, palette_name).html_safe
  end

  def render_labels(words, palette_name)
    words.map { |e| render_label e, palette_name }.join(" ").html_safe
  end
end
