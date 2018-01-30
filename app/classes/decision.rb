class Decision

  attr_accessor :tracking,
                :first_notification_received,
                :tracking_user

  NOTICE_STATUSES = ['first_notification_to_recipient']

  def initialize(tracking_record)
    self.tracking = tracking_record
    self.tracking_user = tracking_record.user
    process
  end

  def deliver_user_notifications
    case tracking_user.configuration.notification_setting
      when 'first_notification_to_recipient'
        if first_notification_received
          #   Todo: Send email
          asdf = 2
        end
      when 'all_updates'
    #     Todo: Send email
        asdf = 3
      else
    #     Do nothing
    end
  end

  private

  def process
    tracking.tracking_statuses.each do |status|
      if status.details.downcase.include?('first notification to recipient')
        self.first_notification_received = true
      end
    end
  end
end