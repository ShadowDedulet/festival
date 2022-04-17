# Сервис получения билетов в зависимости от параметров
class SelectTicketsService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    return select_user_tickets if params[:user_id]
    select_event_tickets if params[:event_id]
  end

  private

  # Выбирает все билеты пользователя по его id
  def select_user_tickets
    tickets = Ticket.ticket_with_event.where(user_id: params[:user_id]) 
    return { result: false, message: 'No any tickets' }  if tickets.empty?
    tickets.map do |ticket| 
      { id: ticket.id,
        type: ticket.ticket_type, 
        status: ticket.status,
        start_price: ticket.start_price,
        event: { name: ticket.name, date_start: ticket.date_start, date_end: ticket.date_end } }
    end
  end

  # выбирает все доступные билеты мероприятия
  def select_event_tickets
    Event.find_by_id(params[:event_id]).tickets.available_tickets.to_h do |ticket|
      [ ticket.ticket_type.to_sym, [ [ :amount, ticket.amount ], [ :price, ticket.start_price ] ].to_h ]
    end
  end
end