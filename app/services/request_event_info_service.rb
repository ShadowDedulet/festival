class RequestEventInfoService
  def initialize(event_date)
    @event_date = event_date
  end

  def call
    get_response_from_reservation
  end

  private

  def get_response_from_reservation
    # передаем @event_date и получаем:
    # количество оставшихся билетов категории simple
    # количество оставшихся билетов категории vip
    # обрабатываем и возвращаем что-то
  end
end