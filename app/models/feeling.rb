# frozen_string_literal: true

class Feeling < ApplicationRecord
  belongs_to :user, inverse_of: :feelings

  FEELING_LIMIT = 4

  enum status: {
    old: 0,
    current: 1
  }
end
