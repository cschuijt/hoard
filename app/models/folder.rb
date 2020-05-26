class Folder < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :commissions

  validates :title, presence: true, length: { in: 3..128 }
end
