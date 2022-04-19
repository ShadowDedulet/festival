class FindTicketService
  attr_reader :ticket_id
  REQUEST_URL = 'http://management:3000/users'.freeze
  
  def initialize(ticket_id)
    @ticket_id = ticket_id
  end

  def call
    ticket = Ticket.find(ticket_id)
    response = HTTP.get(REQUEST_URL, params: { id: ticket.user_id })
  rescue ActiveRecord::RecordNotFound
    { result: false, error: 'Ticket not found', status: 406 }
  rescue HTTP::Error => err
    { result: false, error: err, status: 503 }
  else
    return { result: false, status: 503 } unless response.status == 200
    user = JSON.parse(response.body)
    { id: user['id'], fio: user['fio'], status: 200 }
  end
end