class UsersController < ApplicationController
  before_action :set_user, only: %i[show tickets]
  
  # возвращает журнал входа посетителей по типу действия: entry
  def journal_entry
    response = HTTParty.get('http://service_name/journal?action=entry')
    render json: response.body
  end

  # возвращает журнал выхода посетителей по типу действия: exit
  def journal_exit
    response = HTTParty.get('http://service_name/journal?action=exit')
    render json: response.body
  end

  # возвращает домашнюю страницу пользователя
  def show; end

  # возвращает все билеты пользователя по параметру user_id
  def tickets
    response = HTTParty.get("http://service_name/tickets?user_id=#{@user.id}")
    render json: response.body
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:fcs, :age, :document_number, :document_type, :role, :login, :password)
  end
end
