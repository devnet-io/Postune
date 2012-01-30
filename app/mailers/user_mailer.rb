class UserMailer < ActionMailer::Base
  default :from => "info@postune.com"

  def welcome_email(user) 
  	@user = user
  	@url = "http://postune.com/activate?code=#{user.activation_code}"
  	mail(:to => user.email, :subject => "Welcome to Postune!")	
  end

end
