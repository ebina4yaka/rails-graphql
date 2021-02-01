require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def after_setup
    @user = active_user
  end
  test 'title_validation' do
    # not null
    post = @user.posts.build(image_url:'https://source.unsplash.com/random/', content: 'Test content')
    post.save
    required_msg = ['タイトルを入力してください']
    assert_equal(required_msg, post.errors.full_messages)

    # length
    max = 50
    title = 'a' * (max + 1)
    post.title = title
    post.save
    maxlength_msg = ['タイトルは50文字以内で入力してください']
    assert_equal(maxlength_msg, post.errors.full_messages)
    title = 'あ' * max
    post.title = title
    assert_difference('Post.count', 1) do
      post.save
    end
  end

  test 'content_validation' do
    # not null
    post = @user.posts.build(title: 'Test title', image_url:'https://source.unsplash.com/random/')
    post.save
    required_msg = ['本文を入力してください']
    assert_equal(required_msg, post.errors.full_messages)

    # length
    max = 1000
    content = 'a' * (max + 1)
    post.content = content
    post.save
    maxlength_msg = ['本文は1000文字以内で入力してください']
    assert_equal(maxlength_msg, post.errors.full_messages)
    content = 'あ' * max
    post.content = content
    assert_difference('Post.count', 1) do
      post.save
    end
  end

  test 'author_validation' do
    unactivated_user = User.new(name: "test", email: "test@example.com", screen_name: "test", password: "password")
    unactivated_user.save
    post = unactivated_user.posts.new(title: 'Test title', image_url:'https://source.unsplash.com/random/', content: 'Test content')
    post.save
    unactivated_msg = ['投稿者はメールアドレスが認証されていません']
    assert_equal(unactivated_msg, post.errors.full_messages)
  end

  test 'image_url_validation' do
    # not null
    post = @user.posts.build(title: 'Test title', content: 'Test content')
    post.save
    required_msg = ['画像を入力してください']
    assert_equal(required_msg, post.errors.full_messages)

    post.image_url = 'https://source.unsplash.com/random/'
    assert_difference('Post.count', 1) do
      post.save
    end
  end
end
