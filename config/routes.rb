Rails.application.routes.draw do
  devise_for :users
  root 'page#index'

  mount API => '/api'
  mount GrapeSwaggerRails::Engine, at: '/swagger'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
