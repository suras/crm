require 'nokogiri'
require 'open-uri'
include ERB::Util
class CandidatesController < ApplicationController
  respond_to :html, :xml, :json, :js
  before_filter :authenticate_user!, :get_team, :check_subscription
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

  def get_candidate_tags

    @full_tags = Tag.all
    @tags = @full_tags.select {|tag| tag.name =~ /#{params[:q]}/i}
    @tags = @tags.map{|tag| { "id" => tag.name, "name"=>tag.name} }
    if (!@tags.any?)
      @tags << {"id" => params[:q], "name" => params[:q]}
    end


    respond_to do |format|
      format.json { render :json => @tags.to_json }
    end
  end


  def show
    @candidate = Candidate.find(params[:id])
    if params[:dl]
      send_file(@candidate.resume.path,
                :filename=>"#{@candidate.name.gsub(/\s+/,'_')}.#{File.extname(@candidate.resume_file_name)}",
                :type => @candidate.resume.content_type,
                :disposition => "attachment")
      return
    end
    respond_to do |format|
      format.html
      format.json { render :json => @candidate.to_json }
    end
  end

  def search
    @result = []
    @candidates = current_team.candidates.includes(:notes,:tags).order("first_name")
    if params[:query] && !(params[:query].blank?)
      tag_ids = params[:query].split(",").map{ |t| t.to_i }.uniq
      @tags = Tag.includes(:candidates).where(:id=> tag_ids)
      @candidates.each do |candidate|
        @result << candidate if(candidate.tags & @tags).count == tag_ids.count
      end
    else
      @result = @candidates
    end
    respond_to do |format|
      format.html
      format.json { render :json => @result.to_json }
    end

  end

  def update
    @candidate = Candidate.find(params[:id])
    @candidate.update_attributes(params[:candidate].except(:id, :profile_pic_url, :get_tags,:notes,:added_by,:name,:resume))
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
    @candidates_list = Hash.new
    @main_list = Hash.new
    dates = []
    if params[:call_list_id]
      @call_list = current_user.call_lists.includes(:candidates,:shortlists).find(params[:call_list_id])
      @left_dates = @call_list.candidates.pluck(:left_on).uniq.reject{ |x| x.nil?}.push(nil)
      @candidates = @call_list.candidates if @call_list
      @left_dates.each do |date|
        candidates_list = {}
        candidates_list[:approved_candidates] = @candidates.includes(:shortlists).status('approved',date)
        candidates_list[:newly_added_candidates] = @candidates.includes(:shortlists).status('newly_added',date)
        candidates_list[:date]=date
        dates.push(candidates_list);
      end
      @main_list[:rejected_candidates] = @candidates.includes(:shortlists).status('rejected',"")
      @main_list[:dates] = dates
    end
    respond_to do |f|
      f.html
      f.json { render :json=> @main_list.to_json}
    end
  end
  def candidates

  end
  def get_team
    @team = current_user.team
  end


  def phrase_contents
    # @image_url = params[:url] + params[:type]
    @page = Nokogiri::HTML(open(params[:url]))
    @page = @page.to_s
    if(params[:type] == "linkedin")

      @image_url = @page.match(/(http:\/\/m\.c\.lnkd\.licdn\.com\/mpr\/pub\/)(.+)(\.jpg)/)
      #@image_url = @page.match(/http/)
      @image_url = @image_url[0]
    end

    if(params[:type] == "facebook")
      @image_url = @page.match(/(https:\/\/fbcdn-profile-a\.akamaihd\.net\/hprofile-ak-)(.*?)(\.jpg)/)
      @image_url = @image_url[0]
    end
    respond_with(@image_url, :layout => false)


  end

end
