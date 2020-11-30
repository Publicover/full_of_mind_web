require 'test_helper'

class FeelingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @feeling = feelings(:one)
    @user = @feeling.user
    @old_feeling = Feeling.create!(body: 'old here', user_id: @user.id, status: :old)

    login_as @user
  end

  test 'should get fixtures' do
    assert @feeling.present?
    assert @user.present?
  end

  test 'should know user' do
    assert_equal @user, @feeling.user
  end

  test 'should get index' do
    testable_feeling_count = Feeling.count - Feeling.old.count - Feeling.where.not(user_id: @user.id).count
    get user_feelings_path(@user)
    assert_response :success
    assert_equal testable_feeling_count, @user.feelings.current.count
    refute_equal Feeling.count, @user.feelings.current.count
  end

  test 'should get edit' do
    get edit_user_feeling_path(@user, @feeling)
    assert_response :success
  end

  test 'should create feeling' do
    @user.feelings.each { |feeling| feeling.update(created_at: Time.zone.now - 2.days) }
    assert @user.can_update_today?
    assert_difference ('Feeling.count') do
      post user_feelings_path(@user), params: { feeling: { body: 'testing create', user_id: @user.id } }
    end
    assert_response :redirect
  end

  test 'should not create feeling if !@user.can_update_today?' do
    refute @user.can_update_today?
    assert_no_difference('Feeling.count') do
      post user_feelings_path(@user), params: { feeling: { body: 'testing create', user_id: @user.id } }
    end
  end

  test 'should get update' do
    @user.feelings.each { |feeling| feeling.update(created_at: Time.zone.now - 2.days) }
    assert @user.can_update_today?
    put user_feeling_path(@user, @feeling)
    assert_response :redirect
  end

  test 'should destroy feeling' do
    delete user_feeling_path(@user, @feeling)
    assert_not Feeling.exists?(@feeling.id)
  end

end
