# frozen_string_literal: true

class FeelingsController < ApplicationController
  before_action :set_user
  before_action :set_feeling, except: [:index, :new, :create]

  def index
    # byebug
    @feelings = @user.feelings.current
    @feeling = Feeling.new
  end

  def edit; end

  def create
    @feeling = Feeling.new(feelings_params)

    if @user.can_update_today?
      if @feeling.save
        # byebug
        redirect_to user_feelings_path(@user)
      else
        render 'new'
      end
    else
      render 'index', notice: 'You already recorded a feeling today.'
    end
  end

  def update
    if @user.can_update_today?
      @feeling.old!
      redirect_back(fallback_location: root_path)
    end
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
