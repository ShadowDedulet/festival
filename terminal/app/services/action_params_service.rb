# Сервис для проверки query параметров
class ActionParamsService
  def initialize(params)
    @params = params
  end

  def call
    err = validate_params
    return err if err

    validate_zone
  end

  # Проверяем query
  def validate_params
    raise ArgumentError, 'Empty ticket id' unless @params[:ticket_id]
    raise ArgumentError, 'Empty zone type' unless @params[:zone_type]
  rescue ArgumentError => e
    { response: { result: 'false', error: e } }
  end

  # Проверяем переданный zone_type
  def validate_zone
    ticket = FetchService.call("http://data:3000/tickets/#{@params[:ticket_id]}")
    ticket = JSON.parse(ticket)

    # Нет билета с таким id
    return { response: { result: 'false', error: 'Wrong ticket_id' } } unless ticket['result']

    user = FetchService.call("http://management:3000/users?userid=#{ ticket['user_id'] }")
    user = JSON.parse(user)

    # Все ок
    return { fio: user['fio'], ticket_id: @params[:ticket_id] } if ticket['ticket_type'] == @params[:zone_type]

    # Неверная зона
    {
      response: { result: 'false', error: 'Wrong zone type' },
      fio: user['fio'], ticket_id: @params[:ticket_id]
    }
  end
end
