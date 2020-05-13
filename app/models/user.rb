class User < ApplicationRecord
  devise :omniauthable, :rememberable, :trackable
end
