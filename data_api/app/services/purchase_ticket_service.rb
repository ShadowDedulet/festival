# Сервис покупки билетов
class PurchaseTicketService
  def initialize(params)
    @params = params
  end

  def call
    reservation = Reserve.find_by_id(@params[:reservation_id])
    return { result: false, err: 'Reservation not valid', status: 406 } unless reservation

    ticket = reservation.ticket
    ticket.status = 2
    ticket.user_id = @params[:user_id]
    ticket.save

    reservation.delete

    { result: true, status: 200 }
  end
end
