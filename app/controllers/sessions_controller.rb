class SessionsController < ApplicationController
  def create
    @user = User.find_by(login: params[:login])
    
    if !!@user && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect_to user_path
    else
      message = 'Something went wrong! Make sure your login and password are correct.'
      redirect_to login_path, notice: message
    end
  end
end