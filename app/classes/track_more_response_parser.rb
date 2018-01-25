class TrackMoreResponseParser

  attr_accessor :request_response_code,
                :body_response_code,
                :body,
                :tracking_number,
                :carrier_code,
                :status,
                :statuses

  def initialize(response)
    self.request_response_code = response.code
    parse_response_and_populate_self(response)
  end

  def latest_status
    self.statuses.present? ? self.statuses.first : nil
  end

  private
  def parse_response_and_populate_self(response)
    hash = JSON.parse(response.body).with_indifferent_access
    self.request_response_code = response.code
    self.body_response_code = hash[:meta][:code]
    self.body = hash[:data]
    self.tracking_number = hash[:data][:tracking_number] if hash[:data].present?
    self.carrier_code = hash[:data][:carrier_code] if hash[:data].present?
    self.status = hash[:data][:status] if hash[:data].present?
    self.statuses = set_statuses(hash[:data][:origin_info][:trackinfo]) if hash[:data].present?
  end

  def set_statuses(info)
    return_info = []
    info.each do |track_info|
      obj = {date: track_info[:Date], status_description: track_info[:StatusDescription], details: track_info[:Details]}
      return_info << obj
    end
    return_info
  end
end