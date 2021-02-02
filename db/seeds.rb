
puts "Create user....."
(1..10).each do |i|
  User.create!(username: "user_#{i}", password: "password")
end
puts "Create user done"
