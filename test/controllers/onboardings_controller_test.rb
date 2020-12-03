require 'test_helper'

class OnboardingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @feeling = feelings(:one)
    @user = @feeling.user
    @user.onboarding_complete = false
    @old_feeling = Feeling.create!(body: 'old here', user_id: @user.id, status: :old)

    login_as @user
  end

  test 'should get index' do
    testable_feeling_count = Feeling.count - Feeling.old.count - Feeling.where.not(user_id: @user.id).count
    get user_onboardings_path(@user)
    assert_response :success
    assert_equal testable_feeling_count, @user.feelings.current.count
    refute_equal Feeling.count, @user.feelings.current.count
  end

  test 'should create feeling' do
    @user.feelings.each { |feeling| feeling.update(created_at: Time.zone.now - 2.days) }
    assert @user.can_update_today?
    assert_difference ('Feeling.count') do
      post user_onboardings_path(@user), params: { feeling: { body: 'testing create', user_id: @user.id } }
    end
    assert_response :redirect
  end

  test 'should flip onboarding_complete if user saves fourth feeling' do
    @user.feelings.create!(body: Faker::Games::Witcher.quote, user_id: @user.id)
    assert_difference ('Feeling.count') do
      post user_onboardings_path(@user), params: { feeling: { body: 'testing create', user_id: @user.id } }
    end
    assert_response :redirect
    assert @user.reload.onboarding_complete
  end

end
