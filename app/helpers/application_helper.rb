module ApplicationHelper
  def normalize_flash_keys(key)
    case key
    when "notice"
      key = "success"
    when "alert"
      key = "error"
    else
      key
    end
  end
end
