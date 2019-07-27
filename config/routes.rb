# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/index'
  devise_for :users
  root 'users#index'
  get 'userslists', to: 'users#users_list', as: :userslist
  get 'user/:id/edit', to: 'users#user_edit', as: :edit_user
  patch 'user/:id/user_update', to: 'users#user_update', as: :user_update
end
