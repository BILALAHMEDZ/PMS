# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :manager do
    resources :clients, only: %i[index new create edit update destroy show]
    resources :projects, only: %i[index new create edit update destroy show]
    resources :payments, only: %i[index new create edit update destroy show]
  end

  namespace :admin do
    resources :clients, only: %i[index new create edit update destroy show]
    resources :users, only: %i[index new create edit update destroy show]
    resources :projects, only: %i[index new create edit update destroy show]
    resources :payments, only: %i[index new create edit update destroy show]
  end
  resources :projects, only: %i[index new create edit update destroy show]
  resources :payments, only: %i[index new create edit update destroy show]
  root 'users#index'
  devise_for :users
  resources :users
  get 'user/:id/edit_profile', to: 'users#profile_edit', as: :edit_profile
  patch 'user/:id/profile_update', to: 'users#profile_update', as: :profile_update
  match '*path' => redirect('/'), via: :get
end
