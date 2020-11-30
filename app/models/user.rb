# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :feelings, inverse_of: :user, dependent: :destroy

  def can_update_today?
    feelings.last.created_at < Time.zone.yesterday.end_of_day
  end

  def has_few_enough_feelings?
    feelings.current.count < Feeling::FEELING_LIMIT
  end

  def can_see_feelings_form?
    can_update_today? && has_few_enough_feelings?
  end
end
