class CancelReservationService
  def initialize(reserve_id)
    @reserve_id = reserve_id
  end

  def call
    cancel_reserve_request
  end

  private

  def cancel_reserve_request
    # передаем @reserve_id и получаем в ответ true или false
  end
end
