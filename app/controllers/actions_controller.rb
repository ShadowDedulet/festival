class ActionsController < ApplicationController
  # возвращает форму покупки билета
  def get_purchase

  end

  # возвращает идентификатор купленного билета
  def purchase

  end

  # возвращает форму бронирования билета
  def get_reserve

  end

  # возвращает reserve_id и время окончания брони
  def reserve

  end

  # возвращает форму отмены брони
  def get_cancel_reservation

  end

  # возвращает результат отмены брони: True or False
  def cancel_reservation

  end

  # возвращает форму блокировки билета
  def get_block_ticket

  end

  # возвращает результат блокировки билета: True or False и сообщение об ошибке
  def block_ticket

  end 
end
