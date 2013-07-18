#!/usr/bin/env ruby
#require "rubygems"
#require "bundler/setup"
require "mailman"
#require File.dirname(__FILE__) + "/../config/environment"

#Mailman.config.logger = Logger.new("log/mailman.log")
Mailman.config.poll_interval = 3
Mailman.config.pop3 = {
  server: 'mail.godaddy.com', port: 995, ssl: true,
  username: "catchmail@hootrecruit.com",
  password: "hootrecruit"
}

Mailman::Application.run do
  default do
    begin
      p "Found a new message"
      if message.multipart?
        the_message_html = message.html_part.body.decoded
        the_message_text = message.text_part.body.decoded
        the_message_attachments = []
        message.attachments.each do |attachment|
          file = StringIO.new(attachment.decoded)
          file.class.class_eval { attr_accessor :original_filename, :content_type }
          file.original_filename = attachment.filename
          file.content_type = attachment.mime_type
          attachment = Attachment.new
          attachment.attached_file = file
          attachment.save
          the_message_attachments << attachment
          
        end
        
      else
         
        the_message_html = message.body.decoded
        the_message_text = message.body.decoded
        the_message_attachments = []
        
       
      end
      
      if(message.to.first =~ /^candidate_/)
        unique_id = message.to.first.slice(0, message.to.first.index('@'))
        candidate = Candidate.find_by_unique_id(unique_id)
        user = User.find_by_email(message.from.first)
        if(candidate && user && user.id == candidate.user_id )
     Note.create(:candidate_note => the_message_text, :creater_id => user.id, :candidate_id => candidate.id)
     end
     
     end
    # map attachments with message object and save other stuff and do other processing or trigger other events..
          #Message.create(:from => message.from.first, :to => message.to.first, :subject => message.subject, :html_body => the_message_html, :text_body => the_message_text)

   
    rescue Exception => e
      Mailman.logger.error "Exception occurred while receiving message:\n#{message}"
      Mailman.logger.error [e, *e.backtrace].join("\n")
    end
  end
end