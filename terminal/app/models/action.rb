class Action < ApplicationRecord
  enum action: { exit: 0, enter: 1 }
end
