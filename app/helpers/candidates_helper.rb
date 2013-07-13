module CandidatesHelper
  def get_tags
    tags = Tag.all.map{|tag| { "id"=>tag.id,"name"=>tag.name} }
    raw tags.to_json
  end
  def get_call_list
    raw current_user.call_lists.to_json
  end
end
