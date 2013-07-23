require 'nokogiri'
require 'open-uri'
include ERB::Util
require 'zip/zip'
require 'zip/zipfilesystem'
class CandidatesController < ApplicationController
  respond_to :html, :xml, :json, :js
  before_filter :authenticate, only: [:edit, :update, :destroy]
  
  def new
     if candidate_logged_in? 
       redirect_to edit_candidate_path(current_candidate), :notice => "Youre already logged in"
       false
     end
  
    
    @candidate = Candidate.new
  end

  def create
   
    tag_names = params[:tags].split(',')
    tags = tag_names.collect do |tag_name|
      tag = Tag.find_or_create_by_name(tag_name)

      end
    
    @candidate = Candidate.new(params[:candidate])
    if @candidate.save
      @candidate.tags << tags
      redirect_to edit_candidate_path(@candidate), :notice => "Candidate Added Successfully"
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
    @candidates = Candidate.includes(:notes,:tags).order("first_name")
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
   
    @candidate = current_candidate
     
    if params[:tags].present?
      tag_names = params[:tags].split(',')
      tags = tag_names.collect do |tag_name|
      tag = Tag.find_or_create_by_name(tag_name)
      end
      @candidate.tags << tags
    end
    @candidate.update_attributes(params[:candidate].except(:id))
    respond_to do |f|
      f.html { redirect_to edit_candidate_path(current_candidate), :notice => "Updated Successfully" }
      f.json { render :json => @candidate.to_json}
    end
  end
  
  def edit
    @candidate = current_candidate
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

  def subregion_options
  render partial: 'subregion_select'
  end
   
   
   def sign_in
     
     
    end
    
  
 
   def create_sign_in
   
       if candidate = Candidate.authenticate(params[:email], params[:password])
          session[:candidate_id] = candidate.id
          redirect_to edit_candidate_path(candidate), :notice => "Logged in successfully"
      else
         flash.now[:alert] = "Invalid login/password combination"
          render :action => 'candidate_signin_path'
     end 
   end


  def sign_out
    reset_session
    redirect_to candidate_sign_in_path, :notice => "You successfully logged out"
   end
   
   
   #zipping
   def download_resumes_as_zip
    return unless (session[:candidates].present?)
    generate_zip(session[:candidates]) do |zipname, zip_path, temp_dir|
       send_file(zip_path, :type => "application/zip", :disposition => "attachment; filename=#{zipname}")
       
       session[:candidates] = nil
       
      
       
      #sen_data zip_path, :type => 'application/zip; charset=iso-8859-1; header=present', :disposition => "attachment; filename=zipname"
    end
    
  end


  def export_zip
    session[:candidates] = params[:candidates]
     #redirect_to :action => "download_resumes_as_zip", :candidates => params[:candidates]
     if request.xhr?
        render :json => {
          :location => url_for(:controller => 'candidates', :action => 'download_resumes_as_zip'),
          :flash => {:notice => "Hello "}
        }
      end
  
    end


# Zipfile generator
  def generate_zip(candidates, &block)
    candidates = candidates.split(",").map{ |t| t.to_i }.uniq
    resumes = Candidate.find_all_by_id(candidates)
  # base temp dir
    temp_dir = Dir.mktmpdir
  # path for zip we are about to create, I find that ruby zip needs to write to a real file
    zip_path = File.join(temp_dir, 'export.zip')
    Zip::ZipFile::open(zip_path, true) do |zipfile|
      resumes.each do |res|
        zipfile.get_output_stream(res.resume_file_name) do |io|
          docfile = File.open(res.resume.path, 'r') 
         
          io.write docfile.read
          docfile.close()
      
        end
      end
    end
  # yield the zipfile to the action
    block.call 'export.zip', zip_path, temp_dir
   ensure
  # clean up the tempdir now!
    FileUtils.rm_rf temp_dir if temp_dir
   end
  
   
   #zipping
  
 

end
