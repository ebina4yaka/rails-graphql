10.times do |n|
  name = "user#{n}"
  email = "#{name}@example.com"
  screen_name = "user_#{n}"
  user = User.find_or_initialize_by(name: name, email: email, screen_name: screen_name, activated: true)

  if user.new_record?
    user.password = "password"
    user.save!
  end
end

puts "users = #{User.count}"
