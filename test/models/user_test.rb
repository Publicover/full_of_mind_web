require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should tell if you can post today' do
    @user = users(:one)
    4.times do
      @user.feelings.create!(body: 'testing here', user_id: @user.id)
    end
    refute @user.can_update_today?
    travel 2.days
    assert @user.can_update_today?
  end
end
