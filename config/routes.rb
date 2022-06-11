Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post '/users/login', to: 'users#login'
  post '/users/changepassword', to: 'users#password'
  post '/users/current', to: 'users#current'
  get '/games/incomplete', to: 'games#incomplete'
  post '/games/assignplayer/:id', to: 'games#assign_player'
  resources :users, except:[:new,:edit]
  resources :games, except:[:new,:edit]

end
