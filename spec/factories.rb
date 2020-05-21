FactoryBot.define do
  factory :user do
    provider { "twitter" }
    sequence   :uid
    username { "asdf" }
    name     { "Asdf" }
  end
end
