Rails.application.routes.draw do
	root 'gossips#index'
  get 'team/', to: 'pages#team'
  get 'contact/', to: 'pages#contact'
  resources :gossips
  resources :users
  resources :cities, only:[:show]
  resources :comments
  resources :sessions, only:[:new, :create, :destroy]
  resources :gossips do
  	resources :likes
  end



end
