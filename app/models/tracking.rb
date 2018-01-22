class Tracking < ApplicationRecord

  scope :active_scope, -> { where(is_active: true)}

  validates :tracking_number,
            :user_id,
            presence: true


end
