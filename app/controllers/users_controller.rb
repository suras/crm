class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @user=current_user
    @team = current_team
    @users = @team.users
    @add_more = @team.plan.max_user.to_i > @users.count
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    render "new"
  end
  
  def create
    team = current_team
    if team.plan.max_user.to_i > team.users.count
  	   params[:user][:team_id] = team.id
       params[:user][:user_type] = "User"
       password = Devise.friendly_token.first(8)
       params[:user][:password] = password
       user = User.create(params[:user])
       if user
        GeneralMailer.send_password(user,password).deliver
        flash[:message] = "New User has been created"
        redirect_to users_path
      else 
        render "new"
      end
    else
      redirect_to users_path(), :notice=>"You dont have access to create user. Upgrade your account"
    end
  end

  def update 
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to users_path , :notice =>  "User details Successfully updated"
    else
      render "new"
    end
  end

 
  
  

  def cancel
    @user = User.find(params[:id])
    @user.update_attribute(:status, false)
    redirect_to users_path , :notice =>  "User Cancelled"
  end
  
 
end
