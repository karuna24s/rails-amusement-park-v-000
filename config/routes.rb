Rails.application.routes.draw do
  resources :users
  resources :rides
  resources :attractions
  root 'welcome#home'
  get '/signin' => 'sessions#new'
  post '/signin' =>'sessions#create'
  post '/signout' => 'sessions#destroy'
end
