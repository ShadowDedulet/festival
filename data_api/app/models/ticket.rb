class Ticket < ApplicationRecord
  belongs_to :event
  has_one :reserve, dependent: :destroy

  # Enum для типа билета и статуса
  enum ticket_type: { fan_zone: 0,  vip: 2 }
  enum status: { accessed: 0, reserved: 1, sold: 2, blocked: 3 }

  # валидациии полей
  validates :ticket_type, :status, :event, presence: true
  validates :start_price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :user_id, numericality: { only_integer: true, greater_than: 0, allow_nil: true }

  TICKET_EVENT_STR = 'tickets.id, tickets.ticket_type, tickets.status, tickets.start_price, events.name,
    events.date_start, events.date_end'.freeze

  # Скопы для получения доступных билетов и количества билетов с ценами соответственно
  scope :ticket_with_event, -> { select(TICKET_EVENT_STR).left_joins(:event) }
  scope :available_tickets, -> { select('ticket_type, start_price, COUNT(*) AS amount').group(:ticket_type, :start_price) }
  
end
