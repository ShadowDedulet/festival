class RequestUserTicketInfoService
  def initialize(document_number)
    @document_number = document_number
  end

  def call
    # отправляем запрос в users и проверяем, есть ли у пользователя билет на это мероприятие
    # возвращаем True or False
  end
end
