class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
     search_path()
  end
  def current_team
    current_user.team  if current_user
  end
  def check_subscription
    status = current_team.status
    if(status == "charged")
      return true
    end
    if (status == "rejected")
      if current_user.user_type == "owner"
        redirect_to edit_subscription_path, :notice => "Your payment has been denied for some reason"
        return false
      else
        redirect_to new_user_session_path, :notice => "Problem With Subscription. Contact group owner"
        return false
      end
    end
    if(status == "pending")
      date_diff = (Time.now - current_team.created_at).to_i/(24 * 3600)
      if(date_diff < 14)
        return true
      else
          if current_user.user_type == "owner"
             redirect_to edit_subscription_path, :notice => "Your payment has been denied for some reason"
             return false
         else
             redirect_to new_user_session_path, :notice => "Problem With Subscription. Contact group owner"
             return false
      end
        
     end
    end
  end
end
