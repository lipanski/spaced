# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "main#home"

  resources :questions, except: [:show] do
    post "generate", on: :collection

    resources :answers, only: [:create]
  end

  resources :tags, except: [:new, :create, :show]

  devise_for :users

  # Post-login route
  get "/today", to: "questions#today", as: :user_root

  scope controller: :main do
    get :start
    get :about
  end
end
