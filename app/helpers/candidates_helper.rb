module CandidatesHelper
   def avatar_url(candidate)  
    gravatar_id = Digest::MD5::hexdigest(candidate.email).downcase  
    "http://gravatar.com/avatar/#{gravatar_id}.png"  
  end  
end
