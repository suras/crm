HootQuest::Application.routes.draw do
 
  # get "static_pages/faq"

  # get "static_pages/billing_info"

  root :to => "home#index"

  devise_for :users
  
  match "/search(/:query)" =>"candidates#search", :as => "search"
  match "/stop_here/:call_list_id"=>"call_lists#stop_here"

  get "/candidates/get_candidate_tags", :to => "candidates#get_candidate_tags"
  get "/candidates/phrase_contents", :to => "candidates#phrase_contents"
  match "/call_list" => "call_lists#index"
  match "/approval/:call_list_id/:candidate_id"=> "call_lists#approval"
  match "/shortlists/bulk_update"=>"shortlists#bulk_update"
  match "/get_candidates/:call_list_id" => "candidates#index"
  resources :candidates,:notes,:shortlists,:call_lists
  
  get "users/index", :to =>"users#index", :as => "users_index"
  
  get "uploads/excel", :to => "uploads#new_upload_excel", :as => "new_upload_excel"
  
  post "uploads/excel", :to => "uploads#upload_excel", :as => "upload_excel"
  get  "uploads/excel_jobs", :to => "uploads#excel_jobs"
  
  get "uploads/linkedin", :to => "uploads#new_upload_linkedin", :as => "new_upload_linkedin"
  
  post "uploads/linkedin", :to => "uploads#upload_linkedin", :as => "upload_linkedin"
  
  get "uploads/outlook", :to => "uploads#new_upload_outlook", :as => "new_upload_outlook"
  post "uploads/outlook", :to => "uploads#upload_outlook", :as => "upload_outlook"
  
  get "uploads/docs", :to => "uploads#new_upload_doc", :as => "new_upload_doc"
  post "uploads/docs", :to => "uploads#upload_doc", :as => "upload_doc"

  match "/faq" => "static_pages#faq" 
  match "/pricing" => "static_pages#billing_info" 
  match "/users/accountSettings" => "users#acc_settings"
  post "/users/addMoreUser" => "users#add_more_user", :as =>"add_more_user"
  

  
 
  #get "users/edit/:id" => "users#edit_user" :as => "edit_user"
  #post "users/edit/:id/update" => "users#update_user" ,:as => "update_user"

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
