class UsersController < ApplicationController
  before_filter :authenticate_user!
  layout "candidate"
  def index
    @user=current_user
    @team = current_team
    @users = @team.users
    @add_more = @team.plan.max_user.to_i > @users.count
  end

  def new

  end

  def edit
  end
  def create
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
