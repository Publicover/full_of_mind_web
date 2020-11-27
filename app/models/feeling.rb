class Feeling < ApplicationRecord
  belongs_to :user

  enum status: {
    old: 0,
    current: 1
  }
end
