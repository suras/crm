class GeneralMailer < ActionMailer::Base
  default from: "testing@devbrother.com"
  def send_password(user,password)
  	@user = user
  	@password = password
  	subject= "You have been added to HootRecruit Team"
  	mail(to: @user.email, subject: subject)
  end
end
