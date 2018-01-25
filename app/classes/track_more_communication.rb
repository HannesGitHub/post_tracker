class TrackMoreCommunication

  include HTTParty

  attr_accessor :headers
  base_uri 'api.trackingmore.com/v2'

  def initialize()
    self.headers = {
        'Trackingmore-Api-Key': 'c511a894-56ea-445e-9f55-ded208fd9d86',
        'Content-Type': 'application/json'
    }
  end

  def register_tracking(tracking_number, tracking_record)
    response = self.class.get("/trackings/south-africa-post/#{tracking_number}", headers: self.headers)
    if response.success?
      # Response.code was 200
      parser = TrackMoreResponseParser.new(response)
      if parser.body_response_code == 200
        #   Successfully added ticket
        set_success_status_with_parser(tracking_record, parser)
      else
        # Response was successfull but the data failed somewhere.
        set_failiure_status(tracking_record,"Tracking failed with status code #{parser.body_response_code}")
      end
    else
      # Response.code was not successful.
      set_failiure_status(tracking_record, "Tracking failed with status code #{response.code}")
      # raise response.response
    end
  end

  private
  def set_success_status_with_parser(tracking, parser)
    tracking.tracking_status = "Success"
    if !parser.status.blank?
      tracking.latest_status = "#{parser.latest_status[:status_description]} - #{parser.latest_status[:details]}"
    end
    # Loop through statuses and create and attach new ones to the tracking.
    parser.statuses.each do |s|
      tracking.tracking_statuses.create(date: s[:date], description: s[:status_description], details: s[:details])
    end

    tracking.save
  end
  def set_failiure_status(tracking, status)
    tracking.tracking_status = status
    tracking.save
  end



end