class Folder < ApplicationRecord
  belongs_to :user
  has_many :commissions, through: :filings

  validates :title, presence: true, length: { in: 3..128 }
end
