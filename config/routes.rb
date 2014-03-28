Rails.application.routes.draw do
  namespace :account do
    resources :sessions
    resources :users
  end

  namespace :admin do
    root 'application#index'
    namespace :account do
      root 'application#index'
      resources :sessions
      resources :users
    end
    namespace :admin do
      root 'application#index'
      resources :logs
      resources :users
    end
    namespace :travel do
      root 'application#index'
      resources :attributes do
        member do
          get :delete
          put :publish
          put :cancel
        end
      end
      resources :categories do
        member do
          get :delete
          put :publish
          put :cancel
        end
      end
      resources :cities do
        member do
          get :delete
          put :publish
          put :cancel
        end
      end
      resources :continents do
        member do
          get :delete
          put :publish
          put :cancel
        end
      end
      resources :countries do
        member do
          get :delete
          put :publish
          put :cancel
        end
      end
      resources :languages do
        member do
          get :delete
          put :publish
          put :cancel
        end
      end
      resources :locations do
        member do
          get :delete
          put :publish
          put :cancel
        end
      end
    end
  end

  namespace :travel do
    resources :attributes
    resources :categories
    resources :cities
    resources :continents
    resources :countries
    resources :languages
    resources :locations
  end

  root 'account/users#welcome'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
