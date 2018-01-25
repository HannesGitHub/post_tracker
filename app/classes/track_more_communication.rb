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
        tracking_record.update_tracking_status('Tracking')
        tracking_record.set_latest_status_if_applicable(parser.latest_status)
      else
        # Response was successfull but the data failed somewhere.
        tracking_record.update_tracking_status("Tracking failed with status code #{parser.body_response_code}")
      end
    else
      # Response.code was not successful.
      tracking_record.update_tracking_status("Tracking failed with status code #{response.code}")
      raise response.response
    end
  end
end