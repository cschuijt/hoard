class Commission < ApplicationRecord
  belongs_to :user
  has_many   :filings, dependent: :destroy
  has_many   :folders, through:   :filings

  validates :title,       presence: true, length: { in: 3..128 }
  validates :description,                 length: { maximum: 20000 }

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

  def thumbnail
    if self.files.attached?
      self.files.first.variant(resize_to_limit: [200, 200]).processed.image
    else
      false
    end
  end

  def small
    if self.files.attached?
      self.files.first.variant(resize_to_limit: [100, 100]).processed.image
    else
      false
    end
  end

  # Methods to grab the next/previous n number of commissions from a folder or
  # all of the user's commissions
  def next(n = 1, folder = nil)
    if folder == nil
      user.commissions.where("id > ?", id).first(n)
    else
      filing = folder.filings.find_by(commission_id: id)
      folder.filings.where("id > ?", filing.id).first(n)
    end
  end

  def prev(n = 1, folder = nil)
    if folder == nil
      user.commissions.where("id < ?", id).last(n)
    else
      filing = folder.filings.find_by(commission_id: id)
      folder.filings.where("id < ?", filing.id).last(n)
    end
  end
end
