class Event < ApplicationRecord
  include ActiveModel::Validations # Кастомная валидация даты

  has_many :tickets, dependent: :destroy # DB Relationship

  # Валидации модели
  validates :name, presence: true
  validates_with DateValidator

  # Scope на получения незавершившихся мероприятий
  scope :not_ended, -> { where('date_start > :date or (date_start < :date and date_end > :date)', date: DateTime.now) }
end
