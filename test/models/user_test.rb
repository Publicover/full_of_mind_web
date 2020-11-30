require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    4.times do
      @user.feelings.create!(body: 'testing here', user_id: @user.id)
    end
  end

  test 'should tell if you can post today' do
    refute @user.can_update_today?
    travel 2.days
    assert @user.can_update_today?
  end

  test 'should tell how many feelings you are showing' do
    refute @user.few_enough_feelings?
    @user.feelings.current.last(2).each { |feeling| feeling.delete }
    assert @user.reload.few_enough_feelings?
  end

  test 'should tell if you can see the feelings form' do
    refute @user.can_see_feelings_form?
    @user.feelings.current.last(2).each { |feeling| feeling.delete }
    refute @user.reload.can_see_feelings_form?
    @user.feelings.last.update(created_at: Time.zone.now - 2.days)
    assert @user.reload.can_see_feelings_form?
  end
end
