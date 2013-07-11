class CandidatesController < ApplicationController
  before_filter :authenticate_user!, :get_team
  layout "candidate"
  def new
    @candidate = @team.candidates.new
  end
  
  def create
    params[:candidate][:user_id] = current_user.id
    tag_names = params[:tags].split(',')
    tags = tag_names.collect do |tag_name|
      tag = Tag.find_or_create_by_name(tag_name)
      
    end
    @candidate = @team.candidates.new(params[:candidate])
    if @candidate.save
       @candidate.tags << tags
    redirect_to users_index_path(), :notice => "Candidate Added Successfully"
    
    else 
      
      render :action => "new"
      
    end
    
  end

  def search
    
  end

  def edit
    
  end

  def destroy
    
  end

  def index
    
  end
  
  def get_team
    @team = current_user.team
  end
end
