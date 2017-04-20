Rails.application.routes.draw do
  root 'main#index'
  match 'home', to: 'main#index', as: 'home', via: [:get, :post]
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  #Lists
  match 'lists', to: 'lists#show_lists', as: 'lists', via: [:get, :post]
  match 'my_lists', to: 'lists#my_lists', as: 'my_lists', via: [:get, :post]
  match 'new_list', to: 'lists#create_lists', as: 'new_list', via: [:get, :post]
  match 'save_list', to: 'lists#save_list', as: 'save_list', via: [:get, :post]
  match 'show_list', to: 'lists#show_list', as: 'show_list', via: [:get, :post]
  match 'refresh_list', to: 'lists#refresh_list', as: 'refresh_list', via: [:get, :post]
  match 'delete_list', to: 'lists#delete_list', as: 'delete_list', via: [:get, :post]
  match 'show_admins', to: 'lists#show_admins', as: 'show_admins', via: [:get, :post]
  match 'change_list_owner', to: 'lists#change_list_owner', as: 'change_list_owner', via: [:get, :post]
  #Covers
  match 'covers', to: 'covers#home', as: 'covers', via: [:get, :post]
  match 'add_cover', to: 'covers#add_manually', as: 'add_cover', via: [:get, :post]
  match 'not_found_covers', to: 'covers#not_found', as: 'not_found_covers', via: [:get, :post]
  match 'new_cover', to: 'covers#new_cover', as: 'new_cover', via: [:get, :post]
  match 'cover_upload', to: 'covers#cover_upload', as: 'cover_upload', via: [:get, :post]
  match 'mark_cover_not_found', to: 'covers#mark_not_found', as: 'mark_cover_not_found', via: [:get, :post]
  match 'load_cover', to: 'covers#load_cover', as: 'load_cover', via: [:get, :post]
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
