Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, except: [:show, :edit, :index]
  resources :user_sessions, only: [:create]
  resources :recipes
  resources :meal_plans
  post 'swap_recipe/:id', to: 'meal_plans#swap_recipe', as: :meal_plan_swap_recipe
  post 'update_with_shopping_list/:id', to: 'meal_plans#update_with_shopping_list', as: :meal_plan_with_shopping_list
  post 'toggle_checked_off/:id', to: 'shopping_lists#toggle_ingredient_checked_off', as: :shopping_list_toggle_checked_off

  # Profile aliases
  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout
  get 'edit_profile', to: 'users#edit', as: :edit_profile
  get 'export_to_things/:id', to: 'meal_plans#share_to_things', as: :export_to_things


  root to: 'pages#home'
end
