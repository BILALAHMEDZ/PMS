# frozen_string_literal: true

Rails.application.routes.draw do
  resources :comments
  namespace :manager do
    resources :clients
    resources :projects do
      resources :payments, except: %i[index]
      resources :timelogs, except: %i[index]
    end
    get 'employee/:id/assigned_employees', to: 'projects#assigned_employees', as: :assigned_employees
  end

  namespace :admin do
    resources :clients
    resources :users
    resources :projects do
      resources :payments, except: %i[index]
      resources :timelogs, except: %i[index]
    end
    get 'employee/:id/assigned_employees', to: 'projects#assigned_employees', as: :assigned_employees
  end

  namespace :employee do
    resources :clients, only: %i[index show]
    resources :projects, only: %i[index show] do
      resources :timelogs
    end
  end

  resources :projects, except: %i[index new show destroy edit update create] do
    resources :attachments, only: %i[new index create]
  end
  resources :attachments, only: %i[destroy]

  namespace :api do
    namespace :v1 do
      resources :projects do
        resources :payments, only: %i[index show]
        resources :timelogs, only: %i[index show]
      end
      resources :clients, only: %i[index show]
      resources :users, only: %i[index show]
      resource :users, only: %i[update]
      resources :comments, only: %i[index show]
    end
  end

  post '/auth/login', to: 'authentication#login'

  post '/comments', to: 'comments#create'
  root 'users#index'
  devise_for :users
  resources :users, only: [:index]
  get 'user/:id/edit_profile', to: 'users#profile_edit', as: :edit_profile
  patch 'user/:id/profile_update', to: 'users#profile_update', as: :profile_update
  match '*path' => redirect('/'), via: :get
end
