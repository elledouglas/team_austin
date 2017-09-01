class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

 def welcome_email(user)
   @user = user
   @url  = 'http://example.com/login'
   mail(to: @user.email, subject: 'Welcome to Nobleman')
 end

 def send_message(user_id, message)
   @user = User.find(user_id)
   @message = message
   mail(to: @user.email, subject: 'You have a message from')
 end



end
