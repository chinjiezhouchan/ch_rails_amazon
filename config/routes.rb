Rails.application.routes.draw do

  match(
    "/delayed_job",
    to: DelayedJobWeb,
    anchor: false,
    via: [:get, :post]
  )

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :products, only: [:create, :index, :show, :destroy, :update]
      resource :sessions, only: [:create, :destroy]
    end
  end

  resources :news_articles, only: [:new, :create, :show, :destroy, :index, :edit, :update]

  resources :tags, only: [:show, :index]

  resources :products do
    resources :reviews, only: [ :create, :destroy, :edit, :update ] do
      resources :likes, shallow: true, only: [ :create, :destroy ]
    end
  end

  # get('/product/new', to: "product#new", as: :new_product)
  # post('/product', to: "product#create", as: :products)
  # get('/product', to: "product#index") # products_path
  # get('/product/:id', to: "product#show", as: :one_product)
  # delete('product/:id', to: "product#destroy")
  # get('/product/:id/edit', to: "product#edit", as: :edit_product)
  # patch("/product/:id", to: "product#update")


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create]
  resource :sessions, only: [:new, :create, :destroy]

  get('/', {to: "welcome#index"}) 
  get('/contact', {to: "contact#index"})
  post('/contact/submit', {to: "contact#submit"})
  
  get('/home', {to: "welcome#home"})
  get('/about', {to: "welcome#about"})
end
