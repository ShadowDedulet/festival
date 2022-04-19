class ApplicationController < ActionController::Base
  before_action :require_login

  include ApplicationHelper

  def require_login
    redirect_to new_session_path unless session.include? :user_id
  end
end
