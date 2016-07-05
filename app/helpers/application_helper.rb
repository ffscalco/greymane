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

  def present(model)
    klass = "#{model.class}Presenter".constantize
    klass.new(model)
  end
end
