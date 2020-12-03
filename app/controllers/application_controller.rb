# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?

  def after_sign_in_path_for(resource)
    return user_onboardings_path(current_user) if !resource.can_complete_onboarding?

    user_feelings_path(current_user)
  end
end
