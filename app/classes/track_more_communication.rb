class TrackMoreCommunication

  include HTTParty
  include TrackingStatusUpdateable

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
      parser = TrackMoreResponseParser.new(response, response.code)
      if parser.body_response_code == 200
        #   Successfully added ticket
        set_success_status_with_parser(tracking_record, parser)
        # Here we create a decision that handles whether and when a user should receive an email.
        decision = Decision.new(tracking_record)
        decision.deliver_user_notifications
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

end