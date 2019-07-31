# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :manager do
    resources :clients, only: %i[index new create edit update destroy]
  end

  namespace :admin do
    resources :clients, only: %i[index new create edit update destroy]
    resources :users, only: %i[index new create edit update destroy]
  end

  root 'users#index'
  devise_for :users
  get 'user/:id/edit_profile', to: 'users#profile_edit', as: :edit_profile
  patch 'user/:id/profile_update', to: 'users#profile_update', as: :profile_update
  match '*path' => redirect('/'), via: :get
end
