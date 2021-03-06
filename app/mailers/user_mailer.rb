class UserMailer < ApplicationMailer
  # To get a preview, navigate to: http://localhost:3000/rails/mailers/user_mailer/account_approval_email.
  # A list of previews is also available at: http://localhost:3000/rails/mailers.
  def account_approval_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
