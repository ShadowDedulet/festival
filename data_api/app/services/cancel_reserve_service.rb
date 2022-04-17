# отмена резервации
class CancelReserveService
  attr_reader :reservation_id

  def initialize(params)
    @reservation_id = params[:reservation_id]
  end


  def call
    Reserve.find(reservation_id).ticket.accessed! # смена статуса билета на доступный для продажи
  rescue
    { result: false, err: 'Ticket not found', status: 406 }
  else
    { result: true, status: 200 }
  end
end