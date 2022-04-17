# Сервис блокировки билета пользователя
class BlockTicketService
  attr_reader :role, :ticket_id, :document_number

  def initialize(params)
    @role, @ticket_id, @document_number = params[:user_role], params[:ticket_id], params[:document_number]
  end

  def call
    check_role
    ticket = Ticket.find(ticket_id).blocked! # смена статуса на заблокирован
  rescue ActiveRecord::RecordNotFound
    { result: false, error: 'Ticket not found', status: 406 }
  rescue err
    { result: false, error: err.message, status: 403 }
  else
    { result: true, status: 200 }
  end
  
  private
  
  # Проверка аргумента роли пользователя, если не admin, то заблокировать нельзя
  def check_role
    raise 'Недостаточно прав для блокировки билета' unless role == 'admin'
  end
end