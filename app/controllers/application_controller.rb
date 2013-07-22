class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
     landing_path()
  end
  def current_team
    current_user.team  if current_user
  end

end
