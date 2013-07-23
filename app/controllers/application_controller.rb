class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
     search_path()
  end
  def current_team
    current_user.team  if current_user
  end
  
   protected 
    # Returns the currently logged in user or nil if there isn't one
    def current_candidate
      return unless session[:candidate_id]
      @current_candidate ||= Candidate.find_by_id(session[:candidate_id]) 
    end
 
    # Make current_user available in templates as a helper
    helper_method :current_candidate
 
    # Filter method to enforce a login requirement
    # Apply as a before_filter on any controller you want to protect
    def authenticate
      candidate_logged_in? ? true : access_denied
    end
 
    # Predicate method to test for a logged in user    
    def candidate_logged_in?
      current_candidate.is_a? Candidate
    end
 
    # Make logged_in? available in templates as a helper
    helper_method :logged_in?
 
    def access_denied
      redirect_to candidate_sign_in_path, :notice => "Please log in to continue" and return false
    end

end
