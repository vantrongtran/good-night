FactoryBot.define do
  factory :daily_sleeping_time do
    user { association :user }
    date { Date.today }
    bed_time { DateTime.now }
    wake_up_time { bed_time + 8.hours }
  end
end
