# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: %i[show edit update] do
    resources :feelings, only: %i[index create update destroy]
    resources :onboardings, only: %i[index create update destroy]
  end

  root 'dashboards#index'
end
