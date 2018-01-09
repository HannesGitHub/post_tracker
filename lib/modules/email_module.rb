module EmailModule

  def email_token_to_user
    token = self.generate_email_token

    test = 3
    # Use .deliver_now to send it immediately in a cronjob.
    UserMailer.account_approval_email(self).deliver_now
    # UserMailer.account_approval_email(self).deliver_later



  end

end