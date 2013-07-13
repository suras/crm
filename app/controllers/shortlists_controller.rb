class ShortlistsController < ApplicationController
  def create
    @call_list = params[:call_list_id] ? CallList.find(params[:call_list_id]) : current_user.call_lists.create(:name=>params[:name])
    candidate_ids = params[:candidate_ids].split(",").map{|id| id.to_i}
    candidate_ids.each do |id|
      @call_list.shortlists.create(:candidate_id=>id)
    end
    respond_to do |f|
      f.html
      f.json { render :json=> @call_list.to_json}
    end
  end

  def bulk_update
    @call_list = CallList.find(params[:call_list_id])
    candidate_ids = params[:candidate_ids].split(",").map{|id| id.to_i}
    call_list_ids = @call_list.shortlists.map(&:id)
    remaining_ids = candidate_ids - call_list_ids
    remaining_ids.each do |id|
      @call_list.shortlists.create(:candidate_id=>id)
    end
     respond_to do |f|
      f.html
      f.json { render :json=> {"count"=>remaining_ids.count}.to_json}
    end
  end
end
