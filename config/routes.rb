Rails.application.routes.draw do
  root 'about/pages#show', id: 'home'

  concern :deletable do
    member do
      get :delete
      put :publish
      put :withdraw
    end
  end
  
  concern :batch do
    collection do
      get :batch
      post :batch
    end
  end

  namespace :about do
    resources :audios
    resources :images
    resources :pages
    resources :videos
  end

  namespace :account do
    resources :sessions
    resources :users do
      member do
        get :password
        put :password
        get :setting
        put :setting
      end
      collection do
        get :ajaxValidateFieldName
        get :forget
        post :forget_mail
        get :reset_password
        post :reset_passwd
        get :reset_password_ok
      end
    end
  end

  namespace :admin do
    root 'application#index'
    namespace :about do
      root 'application#index'
      resources :audios, concerns: :deletable
      resources :images, concerns: :deletable
      resources :pages, concerns: :deletable
      resources :videos, concerns: :deletable
    end
    namespace :account do
      root 'application#index'
      resources :connections
      resources :sessions
      resources :users
    end
    namespace :admin do
      root 'application#index'
      resources :assignments
      resources :logs
      resources :permissions
      resources :roles
      resources :users
    end
    namespace :analytic do
      root 'application#index'
      resources :googles
      resources :statistics
    end
    namespace :message do
      root 'application#index'
      resources :emails
      resources :notifications
    end
    namespace :payment do
      root 'application#index'
      resources :currencies
      resources :platforms
      resources :transactions
    end
    namespace :travel do
      root 'application#index'
      resources :attributes, concerns: :deletable
      resources :categories, concerns: :deletable
      resources :cities, concerns: :deletable
      resources :comments
      resources :complaints
      resources :continents, concerns: :deletable
      resources :countries, concerns: :deletable
      resources :bookings, concerns: :deletable
      resources :favorites, concerns: :deletable
      resources :inventories, concerns: [:deletable, :batch]
      resources :journeys, concerns: :deletable
      resources :languages, concerns: :deletable
      resources :locations, concerns: :deletable
      resources :merchants, concerns: :deletable
      resources :products, concerns: :deletable
      resources :questions
      resources :refunds
      resources :services
      resources :tourists
    end
  end

  namespace :business do
    namespace :travel do
      resources :bookings do
        member do
          put :accept
          put :reject
        end
      end
      resources :complaints
      resources :inventories
      resources :journeys
      resources :merchants do
        collection do
          get :reg
        end
      end
      resources :photos
      resources :products do
        member do
          get :journeys
          get :complete
        end
      end
      resources :questions
    end
  end

  namespace :travel do
    resources :attributes
    resources :bookings do
      member do
        get :alipay_return
      end
    end
    resources :categories
    resources :cities
    resources :continents
    resources :costumers
    resources :countries
    resources :favorites
    resources :languages
    resources :locations
    resources :merchants
    resources :products
  end
  
  get '/about/statics(/*path)', to: 'about/statics#index'

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
