# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "main#home"

  resources :questions, except: [:show] do
    post "generate", on: :collection

    resources :answers, only: [:create]
  end

  devise_for :users

  # Post-login route
  get "today", to: "questions#today", as: :user_root

  mount Api::Engine => "/api"
end
