# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "main#home"

  ### Web ###

  resources :questions, except: [:show] do
    post "generate", on: :collection

    resources :answers, only: [:create]

    get :legend, on: :collection
  end

  resources :tags, except: [:new, :create, :show]

  devise_for :users

  # Post-login route
  get "/today", to: "questions#today", as: :user_root

  scope controller: :main do
    get :start
    get :about
  end

  ### GraphQL ###

  # NOTE: We also use Devise for authenticating the API.
  # We'd like to enable helpers (`authenticate_api_credential!`)
  # but we don't want any routes created (`skip: :all`).
  devise_for :api_credentials, skip: :all, failure_app: "GraphqlFailureApp"

  post "/api/graphql", to: "graphql#execute"

  if Rails.env.development?
    get "/graphiql", to: "graphql#graphiql"
  end
end
