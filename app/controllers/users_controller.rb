class UsersController < ApplicationController
  before_filter :authenticate_user!
  layout "candidate"
  def index
    @team = current_user.team
    @candidates = @team.try(:candidates)
  end

  def acc_settings
  	@user=current_user
     #@user.plan
  	max=@user.team.plan.max_user
  	team=@user.team
  	current=team.users.count
  	@more_visibility = current < max ? true : false
  		
  	#render :json => @user	
  end

  def add_more_user
  	stat=User.create(params[:user]);
  	if stat
	  	@user=current_user
	  	 max=@user.team.plan.max_user
	  	team=@user.team
	  	current=team.users.count
	  	@more_visibility = current < max ? true : false
	  	status=1
	 else
       status=0
	 end 	
  	render :json => {"status"=>status,"visible"=>@more_visibility}
  end


  def edit_subscription
    
    @user = current_user if current_user.user_type == "owner"
    
  end
  
  def update_plan
    return unless current_user.user_type == "owner"
    @user = current_user
    if(@user.plan_update(params[:user][:plan_id]))
    redirect_to edit_subscription_path, :notice => "Plan Updated Successfully"
    else
      flash.alert = "unable to update plan"
      render :action => "edit_subscription"
    
    end
    
  end
  
  def update_card
    return unless current_user.user_type == "owner"
    @user = current_user
    if(@user.card_update(params[:user][:stripe_card_token]))
    redirect_to edit_subscription_path, :notice => "Card Updated Successfully"
    else
      flash.alert = "unable to update card"
      render :action => "edit_subscription"
    
    end
    
    
  end
  
end
