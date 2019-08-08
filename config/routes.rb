# frozen_string_literal: true

Rails.application.routes.draw do
  resources :comments
  namespace :manager do
    resources :clients
    resources :projects do
      resources :payments
      resources :timelogs
    end
    get 'employee/:id/assigned_employees', to: 'projects#assigned_employees', as: :assigned_employees
  end

  namespace :admin do
    resources :clients
    resources :users
    resources :projects do
      resources :payments
      resources :timelogs
    end
    get 'employee/:id/assigned_employees', to: 'projects#assigned_employees', as: :assigned_employees
  end

  namespace :employee do
    resources :clients
    resources :projects do
      resources :timelogs
    end
  end

  resources :projects do
    resources :attachments
  end

  post '/comments', to: 'comments#create'
  resources :attachments, only: [:destroy]
  root 'users#index'
  devise_for :users
  resources :users
  get 'user/:id/edit_profile', to: 'users#profile_edit', as: :edit_profile
  patch 'user/:id/profile_update', to: 'users#profile_update', as: :profile_update
  match '*path' => redirect('/'), via: :get
end
