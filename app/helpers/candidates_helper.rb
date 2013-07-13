module CandidatesHelper
  def get_tags
    tags = Tag.all.map{|tag| { "id"=>tag.id,"name"=>tag.name} }
    raw tags.to_json
  end
end
