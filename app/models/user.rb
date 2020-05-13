class User < ApplicationRecord
  devise :omniauthable, :rememberable, :timeoutable, :trackable
end
