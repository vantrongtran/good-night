FactoryBot.define do
  factory :token do
    token { Faker::Internet.device_token }
    expires_at { Settings.auth.token.expires_in.second.from_now }
    user { association :user }
  end
end
