# Evula Andzhey
class ReserveService
  def initialize(params)
    @params = params
  end

  def call
    ticket = find_ticket
    return { result: false, err: 'Tickets/Events not found', status: 406 } unless ticket

    ticket.reserved!

    reserve = Reserve.create(ticket: ticket, time_start: DateTime.now, time_end: DateTime.now + 5.minute)
    { reservation_id: reserve.id, reservation_end_time: reserve.time_end, status: 200 }
  rescue StandardError => e # PLS FIX, NO CATCHING STANDARDS PLS
    return { result: false, err: e, status: 406 }
  end

  private

  # Мы считаем, что не могут быть 2 параллельных мероприятия
  # TODO:
  # иначе передаем список для выбора пользователя
  def find_ticket
    return Ticket.joins(:event).where(
      ['tickets.ticket_type = ? AND tickets.status = 0 AND events.date_start <= ? AND events.date_end >= ?',
       @params[:ticket_type],
       @params[:event_date],
       @params[:event_date]]
    ).first
  end
end
