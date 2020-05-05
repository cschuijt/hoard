class Commission < ApplicationRecord
  validates :title, presence: true, length: { in: 3..128 }
end
