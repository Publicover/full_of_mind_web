# frozen_string_literal: true

class DashboardsController < ApplicationController
  # can't pass current_user to the routes,
  # so we need something to redirect them upon login
  def index
    if current_user.feelings.nil?
      redirect_to user_onboardings_path(current_user)
    else
      redirect_to user_feelings_path(current_user)
    end
  end
end
