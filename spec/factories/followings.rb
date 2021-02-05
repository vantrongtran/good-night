FactoryBot.define do
  factory :following do
    user { association :user }
    following_user { association :user }
  end
end
