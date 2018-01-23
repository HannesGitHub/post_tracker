class Tracking < ApplicationRecord

  belongs_to :user

  scope :active_scope, -> { where(is_active: true)}

  validates :tracking_number,
            :user_id,
            presence: true


end
