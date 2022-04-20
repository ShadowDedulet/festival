class DeleteReservationJob
  include Sidekiq::Job

  def perform(reservation_id)
    PostService.call(
      'http://data:3000/tickets/cancel_reservation',
      { reservation_id: reservation_id }
    )
  end
end
