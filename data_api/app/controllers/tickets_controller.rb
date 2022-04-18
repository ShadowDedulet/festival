class TicketsController < ApplicationController
  before_action :set_ticket, only: :show 
  
  # GET /tickets ## Выводит список билетов в зависимости от параметров user_id или event_id 
  def index
    render json: SelectTicketsService.new(params).call 
  end

  # Пока не знаю для чего он
  def show
    ticket = Ticket.find_by_id(params[:id])
    render json: { event: ticket.event, ticket: ticket }, status: :ok
  end

  # POST /reserve ## Бронирование билетов 
  def reserve
    reserve = ReserveTicketService.new(params).call
    status = reserve.delete(:status)
    render json: reserve, status: status
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

  private

  def set_ticket
    @ticket = Event.find_by_id(params[:id]).where(user_id: params[:user]).tickets.find_by_id(params[:ticket])
  end
end
