Rails.application.routes.draw do
  root to: 'pages#home', :constraints => UserRequiredConstraint.new
  root to: 'pages#landing', :constraints => NoUserRequiredConstraint.new, as: nil

  resources :users, except: [:show, :edit, :index] do
    member do
      get :activate
    end
  end

  get '/privacy_policy', to: 'pages#privacy_policy', as: :privacy_policy
  get '/imprint', to: 'pages#imprint', as: :imprint

  resources :user_sessions, only: [:create]
  resources :recipes
  resources :meal_plans
  resources :beta_candidates, only: %i[create]
  post 'swap_recipe/:id', to: 'meal_plans#swap_recipe', as: :meal_plan_swap_recipe
  post 'update_with_shopping_list/:id', to: 'meal_plans#update_with_shopping_list', as: :meal_plan_with_shopping_list
  post 'toggle_checked_off/:id', to: 'shopping_lists#toggle_ingredient_checked_off', as: :shopping_list_toggle_checked_off

  # Profile aliases
  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout
  get 'edit_profile', to: 'users#edit', as: :edit_profile
  get 'export_to_things/:id', to: 'meal_plans#share_to_things', as: :export_to_things
end
