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

  # NOTE: we also use Devise for authenticating the API:
  # we'd like to enable magic helpers (e.g. `authenticate_api_credential!`)
  # but we don't want any routes created (`skip: :all`)
  devise_for :api_credentials, skip: :all, failure_app: "GraphqlFailureApp"

  post "/api/graphql", to: "graphql#execute"

  if Rails.env.development?
    get "/graphiql", to: "graphql#graphiql"

    # `turbo_stream_from` includes an actioncable pack pointing to the wrong asset server
    get "/packs/js/:pack", pack: /[^\/]+/, to: redirect(status: 302) { |params, _request| "http://localhost:8080/packs/js/#{params[:pack]}" }
  end
end
