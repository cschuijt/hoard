class Folder < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { in: 3..128 }
end
