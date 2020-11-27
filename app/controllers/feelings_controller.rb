# frozen_string_literal: true

class FeelingsController < ApplicationController
  before_action :set_user
  before_action :set_feeling, except: [:index, :new, :create]

  def index
    # byebug
    @feelings = @user.feelings.current
  end

  def new
    @feeling = Feeling.new
  end

  def edit
    # @feelings = @user.feelings.current
  end

  def create
    @feeling = Feeling.new(feelings_params)

    if @feeling.save
      # byebug
      redirect_to user_feelings_path(@user)
    else
      render 'new'
    end
  end

  def update
    @feeling.old!
    redirect_to new_feeling_path(@user)
  end

  def destroy
    @feeling.destroy
    redirect_to user_feelings_path(@user)
  end

  def pick_old
    @feelings = @user.feelings.current
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
