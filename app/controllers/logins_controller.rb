class LoginsController < ApplicationController
  skip_before_action :authenticate

  def show; end

  def create
    redirect_to :login, notice: LoginService.new(params, session).call
  end

  def destroy
    session.delete(:login)
    redirect_to :login, notice: 'Вы вышли'
  end
end
