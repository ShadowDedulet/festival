class TicketsController < ApplicationController
  # before_action :set_ticket, only: :show 
  
  # GET /tickets ## Выводит список билетов в зависимости от параметров user_id или event_id 
  def index
    render json: SelectTicketsService.new(params).call 
  end

  # Получение билета для журнала
  def show
    ticket = FindTicketService.new(params[:id]).call
    status = ticket.delete(:status)
    render json: ticket, status: status
  end

  # POST /reserve ## Бронирование билетов 
  # def reserve
  #   reserve = ReserveTicketService.new(params).call
  #   status = reserve.delete(:status)
  #   render json: reserve, status: status
  # end

  # Evula Andzhey
  def reserve
    reservation = ReserveService.new(params).call
    status = reservation.delete(:status)
    pp(reservation)
    render json: reservation, status: status
  end

  # Evula Andzhey
  def purchase
    purchasement = PurchaseService.new(params).call
    status = purchasement.delete(:status)
    render json: purchasement, status: status
  end

  # POST /cancel_reservation ## отмена резервации билетов
  def cancel_reservation
    cancel_reservation = CancelReserveService.new(params).call
    status = cancel_reservation.delete(:status)
    render json: cancel_reservation, status: status
  end

  # POST /block_tickets ## функция блокировки билета
  def block_ticket
    blocked = BlockTicketService.new(params).call
    status = blocked.delete(:status)
    render json: blocked, status: status
  end
end
