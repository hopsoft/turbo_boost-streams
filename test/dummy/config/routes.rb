# frozen_string_literal: true

Rails.application.routes.draw do
  get "health", to: ->(_env) { [204, {}, [""]] }
  get "frames/:id/:behavior", to: "frames#show", as: :frame
  resources :demos, only: %i[index show update]
  resources :docs, only: %i[index show]
  root "demos#index"
end
