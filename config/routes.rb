Rails.application.routes.draw do
  get 'services/:id' => 'services#show', as: :service

  get 'events/index'

  resources :account_types

  resources :accounts

  devise_for :users
  devise_scope :user do
    get 'login',  to: 'devise/sessions#new'
    get 'register', to: 'devise/registrations#new'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  post '/collector/:id' => 'traffic#index'

  get 'servers/:id' => 'servers#show', as: :server
  get 'servers' => 'servers#index', as: :servers
  get 'servers/:server_id/events' => 'events#index', as: :events

  get 'dashboard' => 'dashboard#index', as: :dashboard

  post 'portlets/reorder' => 'portlets#reorder_server'
  post 'portlets/dashboard/reorder' => 'portlets#reorder_dashboard'

  get 'confirm_email' => 'accounts#confirm', as: :confirm_email

  post 'dashboard_portlets' => 'dashboard_portlets#create', as: :create_dashboard_portlet
  post 'dashboard_portlets/delete' => 'dashboard_portlets#delete', as: :delete_dashboard_portlet
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
