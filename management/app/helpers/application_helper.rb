module ApplicationHelper
  FLASH_TYPES = {
    notice: 'alert-info',
    warning: 'alert-warning',
    success: 'alert-success'
  }

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def flash_messages(type)
    content_tag :div, flash[type], class: "alert #{FLASH_TYPES[type]}" if flash[type].present?
  end
end
