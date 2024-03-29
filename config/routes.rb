Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :users do
    resources :posts
  end

  get '/posts/count', to: 'posts#count'
  resources :posts, controller: 'posts', except: [:new, :edit]

  get '/threads/count', to: 'threads#count'
  resources :threads, controller: 'threads', except: [:new, :edit]
  

end
