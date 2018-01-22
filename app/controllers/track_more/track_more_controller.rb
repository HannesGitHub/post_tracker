class TrackMore::TrackMoreController < ApplicationController
  skip_before_action :verify_authenticity_token

  def webhook_received
    test = 3
  end

end