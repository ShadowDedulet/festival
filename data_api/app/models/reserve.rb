class Reserve < ApplicationRecord
  belongs_to :ticket

  validations :ticket, presence: true
end
