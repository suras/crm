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

  def show
    @candidate = Candidate.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @candidate.to_json }
    end
  end

  def search
    @result = []
    @candidates = current_team.candidates.order("first_name")
    if params[:query]
      tag_ids = params[:query].split(",").map{ |t| t.to_i }.uniq
      @tags = Tag.includes(:candidates).where(:id=> tag_ids)
      @candidates.each do |candidate|
        puts (candidate.tags & @tags).count.to_s + "------" + @tags.count.to_s
        @result << candidate if(candidate.tags & @tags).count == tag_ids.count
      end
    else
      @result = @candidates
    end
    puts @result.inspect
    respond_to do |format|
      format.html
      format.json { render :json => @result.to_json }
    end

  end

  def update
    @candidate = Candidate.find(params[:id])
    @candidate.update_attributes(params[:candidate].except(:id, :profile_pic_url, :get_tags,:notes))
    respond_to do |f|
      f.html { redirect_to candidates_path }
      f.json { render :json => @candidate.to_json}
    end
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
