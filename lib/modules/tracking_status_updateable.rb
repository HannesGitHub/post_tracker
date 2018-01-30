module TrackingStatusUpdateable
  def set_success_status_with_parser(tracking, parser)
    if tracking.blank?
    #   Came from the webook, no was linked. Now find the tracking by tracking number.
      tracking = Tracking.find_by(tracking_number: parser.tracking_number)
    end
    tracking.tracking_status = "Success"
    if !parser.status.blank?
      tracking.latest_status = "#{parser.latest_status[:status_description]} - #{parser.latest_status[:details]}"
    end
    # Loop through statuses and create and attach new ones to the tracking.
    parser.statuses.each do |s|
      tracking.tracking_statuses.create(date: s[:date], description: s[:status_description], details: s[:details])
    end
    tracking.failed = false
    tracking.save
    tracking
  end
  def set_failiure_status(tracking, status)
    tracking.tracking_status = status
    tracking.failed = true
    tracking.save
  end
end