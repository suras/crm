module CandidatesHelper

   def avatar_url(candidate)  
    gravatar_id = Digest::MD5::hexdigest(candidate.email).downcase  
    "http://gravatar.com/avatar/#{gravatar_id}.png"  
  end  

  def get_tags
    tags = Tag.all.map{|tag| { "id"=>tag.id,"name"=>tag.name} }
    cats = []
    cats << Category.all.map{|category| { "id"=>"c"+category.id.to_s, "name"=> category.branch +  " " + category.degree} }
    tags = tags.zip(cats).flatten.compact
    #tags.merge(cats)
    raw tags.to_json
  end

end
