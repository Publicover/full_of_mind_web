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
end
