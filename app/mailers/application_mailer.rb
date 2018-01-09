class ApplicationMailer < ActionMailer::Base
  default from: 'from@localhost:3000'
  layout 'mailer'
end
