class TicketsController < ApplicationController
  # before_action :set_ticket, only: :show 
  
  # GET /tickets ## Выводит список билетов в зависимости от параметров user_id или event_id 
  def index
    tickets = SelectTicketsService.new(params).call 
    status = tickets.delete(:status)
    render json: tickets, status: status
  end

  # Получение билета для журнала
  def show
    ticket = FindTicketService.new(params[:id]).call
    status = ticket.delete(:status)
    render json: ticket, status: status
  end

  # POST /reserve ## Бронирование билетов 
  def reserve
    reservation = ReserveTicketService.new(params).call
    status = reservation.delete(:status)
    pp(reservation)
    render json: reservation, status: status
  end

  # POST /purchase ## Покупка билетов 
  def purchase
    purchasement = PurchaseTicketService.new(params).call
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
