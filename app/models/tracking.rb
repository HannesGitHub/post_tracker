class Tracking < ApplicationRecord

  belongs_to :user

  scope :active_scope, -> { where(is_active: true)}

  validates :tracking_number,
            :user_id,
            presence: true


  def update_tracking_status(status)
    self.tracking_status = status
    self.save
  end

  def set_latest_status_if_applicable(status)
    if !status.blank?
      self.latest_status = "#{status[:status_description]} - #{status[:details]}"
      self.save
    end
  end

end
