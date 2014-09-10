Rails.application.routes.draw do
  resources :everydaytips

  resources :odsreserves

  get 'about/help'

  resources :analysts

  resources :syslogs

  resources :portfoliologs

  resources :weixinlogs

  resources :marketdates do
		get 'reset_marketdate_to_today', on: :collection
	end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { sessions: "users/sessions" }
  get 'welcome/index'

  resources :sysconfigs

  resources :quotationdatafiles do
		get 'doupdate', on: :member
		get 'bxctoodsupdate', on: :member
		get 'dobatch', on: :collection
	end

  resources :reserves do
    post 'qcode', on: :collection
    get 'pubindex', on: :collection
  end

  resources :quotations

  resources :accounts

  resources :portfolios

  resources :users

  mount WeixinRailsMiddleware::Engine, at: "/"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"


  get '/pub/index', to: 'reserves#pubindex', as: 'sysanalyst'
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
