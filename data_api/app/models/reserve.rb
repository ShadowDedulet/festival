class Reserve < ApplicationRecord
  belongs_to :ticket

  validates :ticket, presence: true
end
