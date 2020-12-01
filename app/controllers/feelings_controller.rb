# frozen_string_literal: true

class FeelingsController < ApplicationController
  before_action :set_user
  before_action :set_feeling, except: %i[index create]

  def index
    @feelings = @user.feelings.current
    @feeling = Feeling.new
    @end_time = Time.zone.now.end_of_day - Time.zone.now
  end

  def create
    @feeling = Feeling.new(feelings_params)

    if @user.can_update_today?
      if @feeling.save
        redirect_to user_feelings_path(@user)
      else
        render 'new'
      end
    else
      render 'index', notice: 'You already recorded a feeling today.'
    end
  end

  def update
    return unless @user.can_update_today?

    @feeling.old!
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @feeling.destroy
    redirect_to user_feelings_path(@user)
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
