# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :feelings, inverse_of: :user, dependent: :destroy

  def can_update_today?
    return false if feelings.empty?

    feelings.last.created_at < Time.zone.yesterday.end_of_day
  end

  def few_enough_feelings?
    return false if feelings.nil?

    feelings.current.count < Feeling::FEELING_LIMIT
  end

  def can_complete_onboarding?
    return false if feelings.nil?

    feelings.current.count == Feeling::FEELING_LIMIT
  end

  def can_see_feelings_form?
    can_update_today? && few_enough_feelings?
  end
end
