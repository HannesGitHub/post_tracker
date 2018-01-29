class TrackMore::TrackMoreController < ApplicationController
  skip_before_action :verify_authenticity_token

  include TrackingStatusUpdateable

  def webhook_received
    parser = TrackMoreResponseParser.new(params, response.code)
    if parser.body_response_code == 200
      #   Successfully added ticket
      tracking_record = set_success_status_with_parser(nil, parser)
      # Here we create a decision that handles whether and when a user should receive an email.
      decision = Decision.new(tracking_record)
      decision.deliver_user_notifications
    else
      # Response was successfull but the data failed somewhere.
      set_failiure_status(tracking_record,"Tracking failed with status code #{parser.body_response_code}")
    end
  end

end