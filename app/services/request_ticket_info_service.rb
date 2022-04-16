class RequestTicketInfoService
  def initialize(ticket_type)
    @ticket_type = ticket_type
  end

  def call
    get_response_from_reservation
  end

  private

  def get_response_from_reservation
    # передаем @ticket_type и получаем:
    # начальную цену билета имеющейся категории
    # обрабатываем и возвращаем значение
  end
end
