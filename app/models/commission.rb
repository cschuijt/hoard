class Commission < ApplicationRecord
  belongs_to :user
  has_many   :folders, through: :filings

  validates :title, presence: true, length: { in: 3..128 }

  # File uploads through Active Storage
  has_many_attached :files
  validates :files, content_type: ['image/png', 'image/jpg', 'image/jpeg',
                                   'image/gif', 'image/webp'],
                    size:         { less_than: 10.megabytes }

  def start
    if self.started?
      return false
    else
      self.started    = true
      self.started_at = Time.now

      self.save
    end
  end

  def finish
    if self.finished?
      return false
    else
      self.finished    = true
      self.finished_at = Time.now

      self.save
    end
  end
end
