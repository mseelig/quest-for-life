QuestForLife::Application.routes.draw do

  ActionController::Routing::Routes.draw do |map|
  map.resources :age_groups

  map.resources :survey_groups do |survey_groups|
    survey_groups.resources :surveys
  end


  map.resources :surveys
  map.with_options :controller => 'surveys' do |s|
    s.survey_demographics '/surveys/:id/demographics', :action => :edit, :parameter => 'demographics', :requirements => { :method => :get }
    s.survey_parameter '/surveys/:id/:parameter', :action => :edit, :requirements => { :method => :get }
    s.equation_parameter '/equation/:parameter', :action => :edit, :requirements => { :method => :get }
  end

  map.resources :rational_options

   map.resources :users do |users|
      users.resource :password, :controller => 'clearance/passwords', :only => [:create, :edit, :update]
      users.resource :confirmation, :controller => 'confirmations', :only => [:new, :create]
    end
    
    map.open_id_complete 'session', :controller => 'sessions', :action => 'create', :requirements => { :method => :get }
    map.resource :session, :only => [:new, :create, :destroy]
    
    map.with_options :controller => 'sessions'  do |m|
      m.sign_in  '/login',  :action => 'new'
      m.sign_out '/logout', :action => 'destroy'
    end
    
    

    map.root :controller => "home"

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
