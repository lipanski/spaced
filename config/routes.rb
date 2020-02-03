# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "main#home"

  resources :questions, except: [:show] do
    post "generate", on: :collection
  end

  devise_for :users

  # Post-login default page
  get "questions", to: "questions#index", as: :user_root
end
