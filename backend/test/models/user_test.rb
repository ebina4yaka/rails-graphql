require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def after_setup
    @user = active_user
    @user = active_user
  end

  test 'name_validation' do
    # not null
    user = User.new(email: 'test@example.com', screen_name: 'test', password: 'password')
    user.save
    required_msg = ['名前を入力してください']
    assert_equal(required_msg, user.errors.full_messages)

    # length
    max = 30
    name = 'a' * (max + 1)
    user.name = name
    user.save
    maxlength_msg = ['名前は30文字以内で入力してください']
    assert_equal(maxlength_msg, user.errors.full_messages)
    name = 'あ' * max
    user.name = name
    assert_difference('User.count', 1) do
      user.save
    end
  end

  test 'email_validation' do
    # not null
    user = User.new(name: 'test', screen_name: 'test', password: 'password')
    user.save
    required_msg = ['メールアドレスを入力してください']
    assert_equal(required_msg, user.errors.full_messages)

    # length
    max = 255
    domain = '@example.com'
    email = 'a' * ((max + 1) - domain.length) + domain
    assert max < email.length
    user.email = email
    user.save
    maxlength_msg = ['メールアドレスは255文字以内で入力してください']
    assert_equal(maxlength_msg, user.errors.full_messages)

    # regex pass
    ok_emails = %w(
      A@EX.COM
      a-_@e-x.c-o_m.j_p
      a.a@ex.com
      a@e.co.js
      1.1@ex.com
      a.a+a@ex.com
    )
    ok_emails.each do |item|
      user.email = item
      assert user.save
    end

    # regex error
    ng_emails = %w(
      aaa
      a.ex.com
      メール@ex.com
      a~a@ex.com
      a@|.com
      a@ex.
      .a@ex.com
      a＠ex.com
      Ａ@ex.com
      a@?,com
      １@ex.com
      'a'@ex.com
      a@ex@co.jp
    )
    ng_emails.each do |item|
      user.email = item
      user.save
      format_msg = ['メールアドレスは不正な値です']
      assert_equal(format_msg, user.errors.full_messages)
    end
  end

  test 'screen_name validation' do
    # not null
    user = User.new(name: 'test', email: 'test@example.com', password: 'password')
    user.save
    required_msg = ['ユーザー名を入力してください']
    assert_equal(required_msg, user.errors.full_messages)

    # length
    min = 4
    screen_name = 'a' * (min - 1)
    user.screen_name = screen_name
    user.save
    required_msg = ['ユーザー名は4文字以上で入力してください']
    assert_equal(required_msg, user.errors.full_messages)

    # 書式チェック VALID_SCREEN_NAME_REGEX = /\A[\w\-]+\z/
    ok_screen_names = %w(
      screen---name
      ________
      12341234
      ____name
      name----
      SCREEN_NAME
    )
    ok_screen_names.each do |pass|
      user.screen_name = pass
      assert user.save
    end

    ng_screen_names = %w(
      screen/name
      screen.name
      |~=?+'a'
      １２３４５６７８
      ＡＢＣＤＥＦＧＨ
      screen_name@
    )
    format_msg = ['ユーザー名は半角英数字,-,_が使えます']
    ng_screen_names.each do |pass|
      user.screen_name = pass
      user.save
      assert_equal(format_msg, user.errors.full_messages)
    end

    # unique
    user.screen_name = 'test'
    assert user.save

    new_user = User.new(name: 'test', email: 'test@example.com', screen_name: 'test', password: 'password')
    new_user.save
    unique_msg = ['ユーザー名はすでに存在します']
    assert_equal(unique_msg, new_user.errors.full_messages)
  end

  test 'email_downcase' do
    # email小文字化テスト
    email = 'USER@EXAMPLE.COM'
    user = User.new(email: email)
    user.save
    assert user.email == email.downcase
  end

  test 'active_user_uniqueness' do
    email = 'test@example.com'

    # アクティブユーザーがいない場合、同じメールアドレスが登録できているか
    count = 3
    assert_difference('User.count', count) do
      count.times do |n|
        User.create(name: 'test', email: email , screen_name: "test_#{n}", password: 'password')
      end
    end

    # ユーザーがアクティブになった場合、バリデーションエラーを吐いているか
    active_user = User.find_by(email: email)
    active_user.update!(activated: true)
    assert active_user.activated

    assert_no_difference('User.count') do
      user = User.new(name: 'test', email: email, screen_name: 'test', password: 'password')
      user.save
      uniqueness_msg = ['メールアドレスはすでに存在します']
      assert_equal(uniqueness_msg, user.errors.full_messages)
    end

    # アクティブユーザーがいなくなった場合、ユーザーは保存できているか
    active_user.destroy!
    assert_difference('User.count', 1) do
      User.create(name: 'test', email: email, screen_name: 'test', password: 'password', activated: true)
    end

    # 一意性は保たれているか
    assert_equal(1, User.where(email: email, activated: true).count)
  end

  test 'password_validation' do
    # 入力必須
    user = User.new(name: 'test', email: 'test@example.com', screen_name: 'test')
    user.save
    required_msg = ['パスワードを入力してください']
    assert_equal(required_msg, user.errors.full_messages)

    # min文字以上
    min = 8
    user.password = 'a' * (min - 1)
    user.save
    minlength_msg = ['パスワードは8文字以上で入力してください']
    assert_equal(minlength_msg, user.errors.full_messages)

    # max文字以下
    max = 72
    user.password = 'a' * (max + 1)
    user.save
    maxlength_msg = ['パスワードは72文字以内で入力してください']
    assert_equal(maxlength_msg, user.errors.full_messages)

    # 書式チェック VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
    ok_passwords = %w(
      pass---word
      ________
      12341234
      ____pass
      pass----
      PASSWORD
    )
    ok_passwords.each do |pass|
      user.password = pass
      assert user.save
    end

    ng_passwords = %w(
      pass/word
      pass.word
      |~=?+'a'
      １２３４５６７８
      ＡＢＣＤＥＦＧＨ
      password@
    )
    format_msg = ['パスワードは半角英数字,-,_が使えます']
    ng_passwords.each do |pass|
      user.password = pass
      user.save
      assert_equal(format_msg, user.errors.full_messages)
    end
  end
end
