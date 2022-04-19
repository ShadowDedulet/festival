class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: :tickets

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:error] = 'Error- please try to create an account again.'
      redirect_to new_user_path
    end
  end

  # возвращает домашнюю страницу пользователя
  def show
    @user = User.find(params[:id])
  end

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

  def purchase
    return json: { error: 'Must be at least 13 y/o' } if params[:age] < 13

    user = {
      fio: params[:fio],
      age: params[:age],
      document_number: params[:document_number],
      document_type: params[:document_type]
    }

    # Осуществить проверки:
    #   На наличие такого фио по дате
    #   На наличие такого док_тип + док_нам по дате
    response = PostService.call(
      'http://data:3000/tickets/purchase',
      { reservation_id: params[:reservation_id], user: user }
    )

    session.delete(:reservation_id) if response[:result]
  end

  # возвращает форму бронирования билета
  def get_reserve
    render :reserve_form
  end

  def reserve
    response = PostService.call(
      'http://data:3000/tickets/reserve',
      { ticket_type: params[:ticket_type], event_date: params[:event_date] }
    )

    session[:reservation_id] = response[:reservation_id] if response[:result]

    redirect_to user_get_purchase_path
  end

  # возвращает форму отмены брони
  def get_cancel_reservation
    render :cancel_reservation_form
  end

  def cancel_reservation
    response = PostService.call(
      'http://data:3000/tickets/cancel_reservation',
      { reservation_id: params[:reservation_id] }
    )

    session.delete(:reservation_id) if response[:result]

    redirect_to user_show_path
  end

  # возвращает форму блокировки билета
  def get_block_ticket
    if current_user.admin?
      render :block_ticket_form
    else
      redirect_to :back, notice: 'Access to admin only!'
    end
  end

  def block_ticket
    redirect_to :back, notice: 'Access to admin only!' unless current_user.admin?

    response = PostService.call(
      'http://data:3000/tickets/block_ticket',
      { ticket_id: params[:ticket_id], document_number: params[:document_number] }
    )

    redirect_to user_show_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    pp = params.require(:user).permit(:fio, :age, :document_type, :document_number, :login, :password)
    pp[:document_type] = params[:user][:document_type].to_i
    pp
  end
end
