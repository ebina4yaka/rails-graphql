users = User.all
users.each do |user|
  5.times do |n|
    post = user.posts.new
    post.title = "#{user.name}'s Post #{n}"
    post.content = "#{user.name}'s Post #{n} content text"
    if post.save!
      post.post_image.attach(io: File.open("db/seeds/images/posts/post_#{n + 1}.jpg"), filename: "post_#{n + 1}.jpg")
    end
    unless Post.first.nil?
      user.like(Post.first)
      user.save!
    end
    first_user = User.first
    first_user.like(post)
    first_user.save!
  end
end

puts "posts = #{Post.count}"
