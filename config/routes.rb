BssProject::Application.routes.draw do
  
  mount RedactorRails::Engine => '/redactor_rails'

  get "dashboard/index"

  get "announcements/hide"

  get "inboxes/show"

  get "pages/home"
  get "pages/about"
  get "pages/contact"

  post 'upvotes/create'
  post 'downvotes/create'

  controller :sessions do
    get 'sign_in' => :new
    post 'sign_in' => :create
    delete 'logout' => :destroy
  end  


  post '/:voteable_type/:voteable_id/upvote', to: 'upvotes#create', as: 'upvote'
  post '/:voteable_type/:voteable_id/downvote', to: 'downvotes#create', as: 'downvote'

  post '/:reportable_type/:reportable_id/report', to: 'reports#create', as: 'report'


  resources :idioms do
    resources :tags, shallow: true do # CONTROLLER=tags rake routes
      # will show the difference of shallow: true
      resources :votes, defaults: { voteable: 'tag' }
    end
    resources :comments do
      resources :reports, defaults: { reportable: 'comment' }
    end
    resources :edits do
      resources :reports, defaults: { reportable: 'edit' }
    end  
    resources :reports, defaults: { reportable: 'idiom' }
  end  

  get 'tags/:tag', to: 'idioms#index', as: :tag

  match '/auth/:provider/callback', to: 'sessions#create'
  
  match '/announcements/:id/hide', to: 'announcements#hide', as: 'hide_announcement'

  root :to => 'pages#home'

  resources :users do
    resources :messages, only: [ :new, :create, :show ]
    resources :conversations
    resources :inboxes, only: [ :show ]
  end  

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    resources :users do
      get 'toggle_ban', on: :member
      put 'soft_delete', on: :member
    end
    resources :announcements
    resources :tags
    resources :idioms
    resources :reports
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
