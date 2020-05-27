module ApplicationHelper
  # Helper method for assembling the site title
  def title_for(title)
    if title.nil?
      "Hoard"
    else
      title + " | Hoard"
    end
  end

  # Helper method for rendering nice UIkit flashes
  def flash_type(type)
    if type == "notice"
      "primary"
    elsif type == "alert"
      "danger"
    else
      type
    end
  end

  # Helper method for thumbnail or filler
end
