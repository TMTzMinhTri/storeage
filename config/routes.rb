Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'folder', to: 'folder#create'
  get 'download', to: 'folder#download'
  get 'get', to: 'folder#get_all'
end
