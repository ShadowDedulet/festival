class FindTicketService
  attr_reader :ticket_id
  
  def initialize(ticket_id)
    @ticket_id = ticket_id
  end

  def call
    ticket = Ticket.find(@ticket_id)
    
    # raise ActiveRecord::RecordNotFound if ticket.status != 2
  rescue ActiveRecord::RecordNotFound
    { result: false, error: 'Ticket not found/active', status: 406 }
  else
    { result: true, user_id: ticket.user_id, ticket_type: ticket.ticket_type, status: 200 }
  end
end