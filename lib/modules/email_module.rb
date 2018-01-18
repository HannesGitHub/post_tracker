module EmailModule

  def email_token_to_user
    # Email worker performs the email task in the background.
    # If you want to debug, take the UserMailer out of the EmailWorker and it will run synchronously.
    EmailWorker.perform_async(UserMailer.account_approval_email(self).deliver_now)
  end

end