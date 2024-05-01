# frozen_string_literal: true

require_relative '../test_helper'

class DeviseAuthTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)

    get user_session_url
    sign_in @user
    post user_session_url
  end

  test 'should sign in existing user' do
    get root_path

    assert_response :success
    assert_select 'p', 'nory.baichorov@gi.com'
  end

  test 'should create user and sign in' do
    email = Faker::Internet.email
    password = Faker::Internet.password(min_length: 6, max_length: 10)
    User.create(email:, password:)

    get root_path

    assert_response :success
    assert_select 'div', { class: 'alert alert-primary' }, 'Вы успешно зарегистрировались'
  end

  test 'should sign out' do
    sign_out @user

    get root_path

    assert_response :success
  end

  test 'should auto sign out after inaction' do
    get new_post_url

    assert_response :success

    sleep 1.minute

    get new_post_url

    assert_response :redirect
  end
end
