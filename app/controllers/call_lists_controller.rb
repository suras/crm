class CallListsController < ApplicationController
  layout "call_list"

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
  def approval
  	if params[:candidate_id]
  		@candidate = Candidate.find(params[:candidate_id])
  		@candidate.shortlist.update_attribute("status",params[:status])
	end
	respond_to do |f|
		f.json { render :json=> { :status=>@candidate.shortlist.status,:candidate_id=>@candidate.id}.to_json if @candidate}
		f.html
	end
  end
end
