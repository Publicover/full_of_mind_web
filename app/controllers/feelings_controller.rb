# frozen_string_literal: true

class FeelingsController < ApplicationController
  before_action :set_user
  before_action :set_feeling, except: [:index, :new, :create]

  def index
    @feelings = @user.feelings.current
  end

  def show; end

  def new
    @feeling = Feeling.new
  end

  def edit; end

  def create
    @feeling = Feeling.new(feelings_params)

    if @feeling.save
      redirect_to new_user_feeling_path
    else
      render 'new'
    end
  end

  def update
    @feeling.old!
    redirect_to new_feeling_path
  end

  def destroy
    @feeling.destroy
    redirect_to user_feelings_path
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
