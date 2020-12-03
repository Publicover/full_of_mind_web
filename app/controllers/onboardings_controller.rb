# frozen_string_literal: true

class OnboardingsController < ApplicationController
  before_action :set_user
  before_action :set_feeling, except: %i[index create]

  def index
    @feelings = @user.feelings.current
    @feeling = Feeling.new
  end

  def create
    @feeling = Feeling.new(feelings_params)

    if @feeling.save && !@user.can_complete_onboarding?
      redirect_to user_onboardings_path(@user)
    elsif @feeling.save && @user.can_complete_onboarding?
      @user.update(onboarding_complete: true)
      redirect_to user_feelings_path(@user)
    end
  end

  private

    def feelings_params
      params.require(:feeling).permit(:body, :user_id)
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_feeling
      @feeling = @user.feelings.find(params[:id]) if @user
    end
end
