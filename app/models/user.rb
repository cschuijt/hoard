class User < ApplicationRecord
  devise :omniauthable, :rememberable, :trackable

  validates :username, presence: true
  validates :name,     presence: true
  validates :uid,      presence: true, uniqueness: true

  has_many :commissions

  def self.from_omniauth(auth)
    user = find_or_initialize_by(uid: auth.uid, provider: auth.provider)

    # Reassign these attributes and save them in case they were changed
    # or in case the user is new here
    user.username  = auth.info.nickname
    user.name      = auth.info.name
    user.image_url = auth.info.image
    user.save

    # Return the user object
    user
  end
end
