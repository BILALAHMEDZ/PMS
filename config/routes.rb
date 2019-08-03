# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :manager do
    resources :clients
    resources :projects
    resources :payments
    get 'employee/:id/assigned_employees', to: 'projects#assigned_employees', as: :assigned_employees
  end

  namespace :admin do
    resources :clients
    resources :users
    resources :projects
    resources :payments
    get 'employee/:id/assigned_employees', to: 'projects#assigned_employees', as: :assigned_employees
  end
  root 'users#index'
  devise_for :users
  resources :users
  get 'user/:id/edit_profile', to: 'users#profile_edit', as: :edit_profile
  patch 'user/:id/profile_update', to: 'users#profile_update', as: :profile_update
  match '*path' => redirect('/'), via: :get
end
