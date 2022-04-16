class BuyTicketService
  def initialize(options={})
    @fcs = options[:fcs]
    @reserve_id = options[:reserve_id]
    @age = options[:age]
    @document_number = options[:document_number]
    @document_type = options[:document_type]
  end

  def call
    buying_ticket
  end

  private

  def buying_ticket
    if @age >= 13 && RequestReservationInfoService.new(@reserve_id).call && RequestUserTicketInfoService.new(@document_number).call
      # Если все проверки прошли успешно - покупаем билет и возвращаем в ответ id билета?
    end
  end
end
