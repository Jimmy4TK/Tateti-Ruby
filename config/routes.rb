Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post '/users/login', to: 'users#login'
  post '/users/current', to: 'users#current'
  post '/users/:id/changepassword', to: 'users#password'
  get '/users/:id/signout', to: 'users#signout'
  post 'games/:id/move', to: 'games#move'
  post '/games/:id/assignplayer', to: 'games#assign_player'
  get '/games/:id/checkplayer', to:'games#check_player'
  get '/games/incomplete', to: 'games#incomplete'
  resources :users, only:[:create]
  resources :games, only:[:create]

end
