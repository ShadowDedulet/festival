class CalcTicketPriceService
  def initialize(ticket_type, event_date)
    @ticket_type = ticket_type
    @event_date = event_date
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

  def calculation_by_ticket_type
    percents = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

    case @ticket_type
    when 1
      percents.inject(current_tickets[:fan_zone][:price]) do |price, ticket|
        if ((150 - current_tickets[:fan_zone][:amount]) / 1.5).between?(ticket, percents[percents.index(ticket).next]) && ticket != 100
          price += (price / 100 * ticket)
        end
      end
    when 2
      percents.inject(current_tickets[:vip][:price]) do |price, ticket|
        if ((50 - current_tickets[:vip][:amount]) / 0.5).between?(ticket, percents[percents.index(ticket).next]) && ticket != 100
          price += (price / 100 * ticket)
        end
      end
    end
  end

  def event_id
    id = 0

    response = HTTParty.get('http://data:3000/events')

    response.body.each do |event|
      id += event[:id] if event[:date_start] == @event_date
    end
    id
  end

  def current_tickets
    HTTParty.get("http://data:3000/tickets?event_id=#{event_id}")
  end
end
