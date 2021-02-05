
ActiveRecord::Base.transaction do
  puts "Create user records....."
  (1..10).each do |i|
    User.create! username: "user_#{i}", password: "password"
  end
  puts "Create user record done!"
  users = User.last(10)
  puts "Create daily sleeping records....."
  users.each do |user|
    (2..6).each do |i|
      time = i.days.ago.beginning_of_day
      user.daily_sleeping_times.create! date: time.to_date,
        bed_time: (time + rand(20..23).hours), wake_up_time: (time.tomorrow + rand(5..8).hours)
    end
  end
  puts "Create daily sleeping records done!"

  puts "Create following records....."
  following = users[2..10]
  following.each { |following| users.first.followings.create! following_user: following }
  puts "Create following records done!"
end
