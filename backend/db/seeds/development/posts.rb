users = User.all
users.each do |user|
  10.times do |n|
    post = user.posts.new
    post.title = "#{user.name}'s Post #{n}"
    post.image_url = "https://source.unsplash.com/random/post_#{n}"
    post.content = "#{user.name}'s Post #{n} content text"
    post.save!
  end
end

puts "posts = #{Post.count}"
