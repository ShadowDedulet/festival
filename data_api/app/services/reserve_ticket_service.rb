# Сервис бронирования билетов
class ReserveTicketService
  attr_reader :ticket_id

  def initialize(params)
    @ticket_id = params[:id]
  end

  def call
      ticket = find_ticket
    rescue ActiveRecord::RecordNotFound => err
      { result: false, err: err.message, status: 406 }
    else
      ticket.reserved! # смена статуса билета на "забронированный"
      time = DateTime.now
      reserve = Reserve.create(ticket: ticket, time_start: time, time_end: time + 5.minute) # создание записи в таблице бронирования
      { reserve_id: reserve.id, end_reservation_time: reserve.time_end, status: 200 }
  end

  private 

  # Поиск первого доступного для продажи билета
  def find_ticket
    ticket = Ticket.find_by(user_id: nil, status: :accessed)
    raise ActiveRecord::RecordNotFound, 'Ticket not found' if ticket.nil?
    ticket
  end
end