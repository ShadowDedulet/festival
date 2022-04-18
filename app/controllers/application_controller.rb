class ApplicationController < ActionController::Base
  before_action :authenticate

  def authenticate
    redirect_to login_path, notice: 'Необходимо авторизоваться!' unless session[:login]
  end
end
