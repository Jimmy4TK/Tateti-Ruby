Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post '/users/login', to: 'users#login'
  post '/users/changepassword', to: 'users#password'
  post '/users/current', to: 'users#current'
  post 'games/game/:id', to: 'games#game'
  get '/games/incomplete', to: 'games#incomplete'
  post '/games/assignplayer/:id', to: 'games#assign_player'
  get '/games/checkplayer/:id', to:'games#check_player'
  resources :users, except:[:new,:edit,:show,:index]
  resources :games, except:[:new,:edit,:show,:index,:update]

end
