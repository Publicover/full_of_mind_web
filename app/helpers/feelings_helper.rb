# frozen_string_literal: true

module FeelingsHelper
  def post_time
    distance_of_time_in_words(Time.zone.now.end_of_day - Time.zone.now)
  end
end
