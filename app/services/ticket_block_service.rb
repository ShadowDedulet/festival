class TicketBlockService
  def initialize(user, ticket_id, document_number)
    @user = user
    @ticket_id = ticket_id
    @document_number = document_number
  end

  def call
    block_ticket if same?
  end

  private

  def block_ticket
    # отправляем запрос на блокировку билета используя @ticket_id
  end

  def same?
    @user.document_number == @document_number
  end
end
