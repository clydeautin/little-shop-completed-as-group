class Invoice < ApplicationRecord
  enum status: {
    in_progress: 0,
    completed: 1,
    cancelled: 2
  }
end