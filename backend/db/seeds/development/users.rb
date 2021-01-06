10.times do |n|
  name = "user#{n}"
  email = "#{name}@example.com"
  user_id = "user_#{n}"
  user = User.find_or_initialize_by(name: name, email: email, user_id: user_id, activated: true)

  if user.new_record?
    user.password = "password"
    user.save!
  end
end

puts "users = #{User.count}"
