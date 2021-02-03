FactoryBot.define do
  factory :user do
    username { "#{Faker::Internet.user_name}_#{rand(100)}" }
    password { Faker::Internet.password }
  end
end
