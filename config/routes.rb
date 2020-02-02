Rails.application.routes.draw do
  root to: "main#home"

  get "restricted", to: "main#restricted"

  devise_for :users
end
