class CallListsController < ApplicationController
  def index

  end
  def destroy
  	@call_list = current_user.call_lists.find(params[:id])
  	respond_to do |f|
  		f.json do 
  			render :json=>{"status"=>true} if @call_list.try(:delete)
  		end
  	end
  end
  def stop_here
    @call_list = CallList.find(params[:call_list_id])
    can_ids= params[:candidate_ids].split(",").map{|x| x.to_i}
    @shortlists = @call_list.shortlists.where(:candidate_id=>can_ids)
    @shortlists.update_all(:left_on => Date.today)
    respond_to do |f|
      f.json { render :json=> { :status=>true}.to_json if @shortlists }
      f.html
    end  
  end
  def approval
    if params[:candidate_id]
      @call_list = CallList.find(params[:call_list_id])
    	@shortlist = @call_list.shortlists.find_by_candidate_id(params[:candidate_id])
    	@shortlist.status = params[:status]
      @shortlist.left_on = nil if@shortlist.status == "rejected"
      @shortlist.save
   end
  	respond_to do |f|
  		f.json { render :json=> { :status=>@shortlist.status}.to_json if @shortlist}
  		f.html
  	end
  end
end
