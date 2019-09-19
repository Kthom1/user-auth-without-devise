class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Our Site')
  end

  def reset_password_email(user)
    @url = reset_url(token: user.generate_reset_password_token)
    mail(to: user.email, subject: 'Reset Password')
  end
end
