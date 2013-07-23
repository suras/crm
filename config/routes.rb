HootQuest::Application.routes.draw do
 
  resources :categories


  # get "static_pages/faq"

  # get "static_pages/billing_info"
  devise_for :users

 
  match "/search(/:query)" =>"candidates#search", :as => "search"
  
  get '/candidates/subregion_options' => 'candidates#subregion_options'
  
  get '/candidates/download_resumes_as_zip' => "candidates#download_resumes_as_zip"
  post '/candidates/download_resumes_as_zip' => "candidates#download_resumes_as_zip"
  post '/candidates/export_zip' => "candidates#export_zip"

  get "/candidates/get_candidate_tags", :to => "candidates#get_candidate_tags"
  
  get "/candidates/sign_in", :to => "candidates#sign_in", :as => "candidate_sign_in"
  post "/candidates/create_sign_in", :to => "candidates#create_sign_in" , :as => "candidate_create_sign_in"
  delete "/candidates/sign_out", :to => "candidates#sign_out" , :as => "candidate_sign_out"

  match "/landing" => "home#landing", :as=> "landing"
  
  match "/faq" => "static_pages#faq" 
  match "/pricing" => "home#pricing" 
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
