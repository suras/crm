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
end
