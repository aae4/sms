Sms::Application.routes.draw do
  get "groups/index"

  get "groups/edit"

  get "groups/show"

  get "users/new", :as => :users_new

  devise_for :services
  get "home/cabinet", :as => "cabinet"
  get "home/personal", :as => "personal"
  get "home/statistics", :as => "statistics"
  get "home/configurations", :as => "configurations"


  get "home/index", :as => :home
  get "home/help", :as => :home_help

  get "home/generate_api_key", :as => "generate_api_key"
  get "home/api_commands", :as => "api_commands"
  
  #get "messages/new", :as => :messages_new
  
  resources :groups
  resources :messages
  match "messages/:id/send_msg" => "messages#send_msg", :as => "send_msg_message"
  resources :users

  namespace :api do
    resources :messages do
      collection do
        get :all
        get :create_message
      end
    end
    resources :contacts do
      collection do
        get :all
        get :create_contact
        get :delete_contact
      end
    end
    resources :groups do
      collection do
        get :all
        get :create_group
        get :delete_group
      end
    end
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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
