class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

 def welcome_email(user)
   @user = user
   @url  = 'http://example.com/login'
   mail(to: 'kathleenmcclay@gmail.com', subject: 'Welcome to Nobleman')
 end

  # password reset method used in User model method send_password_reset_email
  def password_reset(user)
   @user = user
   mail to: user.email, subject: "Password reset"
  end

end
