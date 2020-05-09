module ApplicationHelper
  def title_for(title)
    if title.nil?
      "Hoard"
    else
      title + " | Hoard"
    end
  end
end
