class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

 def welcome_email(user)
   @user = user
   @url  = 'http://example.com/login'
   mail(to: 'kathleenmcclay@gmail.com', subject: 'Welcome to Nobleman')
 end
end
