class Filing < ApplicationRecord
  belongs_to :commission
  belongs_to :folder
end
