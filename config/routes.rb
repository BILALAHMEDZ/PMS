# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    get 'user/:id/edit', to: 'users#edit', as: :edit_user
    delete 'user/:id/destroy', to: 'users#destroy', as: :destroy_user
    resources :users
  end
  root 'users#index'
  devise_for :users
  get 'user/:id/edit_profile', to: 'users#profile_edit', as: :edit_profile
  patch 'user/:id/profile_update', to: 'users#profile_update', as: :profile_update
end
