class Feeling < ApplicationRecord
  belongs_to :user, inverse_of: :feelings

  enum status: {
    old: 0,
    current: 1
  }
end
