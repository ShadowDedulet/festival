class CalcTicketPriceService
  def initialize(ticket_type, event_date)
    @ticket_type = ticket_type
    @event_date = event_date

    @event_current_simple_count = RequestEventInfoService.new(event_date).call
    @event_current_vip_count = RequestEventInfoService.new(event_date).call
    @ticket_price = RequestTicketInfoService.new(ticket_type).call
  end

  def call
    calculation_price
  end

  private

  def calculation_price
    calculation_by_ticket_type if right_date?
  end

  def right_date?
    Time.now <= @event_date
  end

   # возвращает кол-во и цену билетов каждой категории для мероприятия
   def get_available_tickets

   end

  def calculation_by_ticket_type
    percents = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

    case @ticket_type
    when 1
      percents.inject(@ticket_price) do |price, ticket|
        if ((150 - @event_current_simple_count) / 1.5).between?(ticket, percents[percents.index(ticket).next]) && ticket != 100
          price += (price / 100 * ticket)
        end
      end
    when 2
      percents.inject(@ticket_price) do |price, ticket|
        if ((50 - @event_current_vip_count) / 0.5).between?(ticket, percents[percents.index(ticket).next]) && ticket != 100
          price += (price / 100 * ticket)
        end
      end
    end
  end
end
