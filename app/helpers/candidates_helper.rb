module CandidatesHelper

   def avatar_url(candidate)  
    gravatar_id = Digest::MD5::hexdigest(candidate.email).downcase  
    "http://gravatar.com/avatar/#{gravatar_id}.png"  
  end  

  def get_tags
    tags = Tag.all.map{|tag| { "id"=>tag.id,"name"=>tag.name} }
    raw tags.to_json
  end

end
