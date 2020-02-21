Api::Engine.routes.draw do
  resources :questions, only: [:index]
end
