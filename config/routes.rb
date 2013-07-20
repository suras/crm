HootQuest::Application.routes.draw do
 
  # get "static_pages/faq"

  # get "static_pages/billing_info"
  devise_for :users

  mount StripeEvent::Engine => '/stripe'
  match "/search(/:query)" =>"candidates#search", :as => "search"
  match "/stop_here/:call_list_id"=>"call_lists#stop_here"

  get "/candidates/get_candidate_tags", :to => "candidates#get_candidate_tags"
  get "/candidates/phrase_contents", :to => "candidates#phrase_contents"
  match "/call_list" => "call_lists#index"
  match "/approval/:call_list_id/:candidate_id"=> "call_lists#approval"
  match "/shortlists/bulk_update"=>"shortlists#bulk_update"
  match "/get_candidates/:call_list_id" => "candidates#index"

  get "/users/edit_subscription" => "users#edit_subscription", :as => "edit_subscription"
  put "/users/update_card" => "users#update_card", :as => "update_card"
  put "/users/update_plan" => "users#update_plan", :as => "update_plan"

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
  scope '/account' do
    match "/" => "users#index"
    match "/cancel/:id"=> "users#cancel", :as=>"cancel_user"
    match "/users/edit_subscription" => "users#edit_subscription", :as => "edit_subscription"
    match "/update_card" => "users#update_card", :as => "update_card", :via=>"put"
    match "/update_plan" => "users#update_plan", :as => "update_plan", :via=>"put"
    resources :users
  end
  resources :candidates,:notes,:shortlists,:call_lists#,:users
  root :to => "home#index"

end
