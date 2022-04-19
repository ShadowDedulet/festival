class UsersController < ApplicationController
  before_action :set_user, only: %i[show tickets]
  
  # возвращает журнал входа посетителей по типу действия: entry
  def journal
    if current_user.admin?
      response = HTTParty.get('http://terminal:8080/journal')
      
      respond_to do |format|
        if params[:action] == 'entry'
          format.json { render json: response.body[:entry] }
        elsif params[:action] == 'exit'
          format.json { render json: response.body[:exit] }
        end
      end
    else
      redirect_to :back, notice: 'Access to admin only!'
    end
  end

  # возвращает домашнюю страницу пользователя
  def show; end

  # возвращает все билеты пользователя по параметру user_id
  def tickets
    response = HTTParty.get("http://danil:3000/tickets?user_id=#{current_user.id}")
    render json: response.body
  end

  def user_info
    user = User.find(params[:user_id])
    render json: user
  end

  # возвращает форму покупки билета
  def get_purchase
    render :purchase_form
  end

  # возвращает форму бронирования билета
  def get_reserve
    render :reserve_form
  end

  # возвращает форму отмены брони
  def get_cancel_reservation
    render :cancel_reservation_form
  end

  # возвращает форму блокировки билета
  def get_block_ticket
    if current_user.admin?
      render :block_ticket_form
    else
      redirect_to :back, notice: 'Access to admin only!'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:fio, :age, :document_number, :document_type, :role, :login, :password)
  end
end
