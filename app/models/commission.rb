class Commission < ApplicationRecord
  validates :title, presence: true, length: { in: 3..128 }

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
