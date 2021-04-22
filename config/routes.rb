Rails.application.routes.draw do
  root "photos#index"

  #get "/users/:id" => "users#show", as: users

  
  devise_for :users

  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos


  get ":username/liked" => "photos#liked", as: :liked_photos
  get ":username/feed" => "photos#feed", as: :feed
  get ":username/followers" => "users#followers", as: :followers
  get ":username/following" => "users#following", as: :following


  get "/:username" => "users#show",  as: :user

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
