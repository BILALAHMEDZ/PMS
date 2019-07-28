# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/index'
  devise_for :users
  root 'users#index'
  get 'userslists', to: 'users#users_list', as: :userslist
  get 'user/:id/edit', to: 'users#user_edit', as: :edit_user
  patch 'user/:id/user_update', to: 'users#user_update', as: :user_update
  get 'user/:id/edit_profile', to: 'users#profile_edit', as: :edit_profile
  patch 'user/:id/profile_update', to: 'users#profile_update', as: :profile_update
  delete 'user/:id/destroy_user', to: 'users#destroy_user', as: :destroy_user
end
