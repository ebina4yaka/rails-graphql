60.times do |n|
  name = "user#{n}"
  email = "#{name}@example.com"
  screen_name = "user_#{n}"
  biography = "My name is user#{n}."
  user = User.find_or_initialize_by(
    name: name,
    email: email,
    screen_name: screen_name,
    activated: true,
    biography: biography,
  )

  if user.new_record?
    user.password = "password"
    if user.save!
      user.avatar_image.attach(io: File.open("db/seeds/images/users/user_#{n + 1}.jpg"), filename: "avatar_#{n + 1}.jpg")
    end
  end

  unless User.first.nil?
    first_user = User.first
    user.follow(first_user)
    user.save!
    first_user.follow(user)
    first_user.save!
  end
end

puts "users = #{User.count}"
