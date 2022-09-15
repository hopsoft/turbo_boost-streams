# frozen_string_literal: true

Rails.application.routes.draw do
  get "frames/:id/:behavior", to: "frames#show", as: :frame
  resources :demos, only: %i[index show update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "demos#index"
end
