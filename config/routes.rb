Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, except: [:show, :edit, :index]
  resources :user_sessions, only: [:create]
  resources :recipes
  resources :meal_plans
  post 'swap_recipe/:id', to: 'meal_plans#swap_recipe', as: :meal_plan_swap_recipe
  post 'update_with_shopping_list/:id', to: 'meal_plans#update_with_shopping_list', as: :meal_plan_with_shopping_list

  # Profile aliases
  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout
  get 'profile', to: 'users#show', as: :profile
  get 'edit_profile', to: 'users#edit', as: :edit_profile


  root to: 'pages#home'
end
