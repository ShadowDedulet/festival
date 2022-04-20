class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  # before_action :set_user, only: :tickets

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:error] = "Error- please try to create an account again."
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
      response = HTTParty.get('http://terminal:3000/journal')
      
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
    response = HTTParty.get("http://data:3000/tickets?user_id=#{current_user.id}")
    if response.code == 404
      @tickets = { message: response['message'], status: response.code } 
    else
      @tickets = JSON.parse(response.body).map do |ticket|
        {
          type: ticket['type'],
          start_price: ticket['start_price'],
          event: ticket['event']
        }
      end
    end
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
    pp = params.require(:user).permit(:fio, :age, :document_type, :document_number, :login, :password)
    pp[:document_type] = params[:user][:document_type].to_i
    return pp
  end
end
