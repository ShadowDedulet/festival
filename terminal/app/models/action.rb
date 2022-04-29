class Action < ApplicationRecord
  scope :last_action, -> { where(status: true).order('created_at DESC').first }

  enum action_type: { exit: 0, enter: 1 }
end
