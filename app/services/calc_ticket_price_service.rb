class CalcTicketPriceService
  def initialize(ticket, event)
    @ticket = ticket
    @event = event
  end

  def call
    calculation_price
  end

  private

  def calculation_price
    calculation_by_ticket_type if right_date?
  end

  def right_date?
    Time.now <= @event.date_start
  end

  def calculation_by_ticket_type
    percents = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

    case @ticket.type
    when 1
      percents.inject(@ticket.start_price) do |price, ticket|
        if ((150 - @event.current_simple.count) / 1.5)
            .between?(ticket, percents[percents.index(ticket).next]) && ticket != 100
          price += (price / 100 * ticket)
        end
      end
    when 2
      percents.inject(@ticket.start_price) do |price, ticket|
        if ((150 - @event.current_vip.count) / 1.5)
            .between?(ticket, percents[percents.index(ticket).next]) && ticket != 100
          price += (price / 100 * ticket)
        end
      end
    end
  end
end

# @event.current_vip - оставшиеся билеты типа vip
# @event.current_simple - оставшиеся билеты типа simple
