class UsersController < ApplicationController
  # возвращает журнал входа / выхода посетителей по типу действия (entry / exit)
  def journal

  end

  # возвращает домашнюю страницу пользователя
  def index

  end

  # возвращает форму авторизации (опционально)
  def login

  end

  # возвращает все билеты пользователя по параметру user_id
  def tickets

  end

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

  # возвращает фору отмены брони
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
  
  private

  def journal_entry

  end

  def journal_exit

  end
end