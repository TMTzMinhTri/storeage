Rails.application.routes.draw do
  # root 'page#index'
  devise_for :users
  # get 'contact', to: 'page#contact'

  # mount API => '/api'
  # mount GrapeSwaggerRails::Engine, at: '/swagger'
end
