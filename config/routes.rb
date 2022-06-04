Rails.application.routes.draw do
  resources :listings

  post "listings/:id/order", to: "listings#place_order", as: "place_order"

  devise_for :users
  root 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
