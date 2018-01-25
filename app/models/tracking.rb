class Tracking < ApplicationRecord

  belongs_to :user
  has_many :tracking_statuses

  scope :active_scope, -> { where(is_active: true)}

  validates :tracking_number,
            :user_id,
            presence: true


end
