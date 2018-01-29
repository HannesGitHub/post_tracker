class Tracking < ApplicationRecord

  belongs_to :user
  has_many :tracking_statuses

  scope :active_scope, -> { where(is_active: true)}
  scope :active_and_ongoing, -> {where(is_active: true).where(is_completed: false).where(failed: false)}
  scope :completed, -> { where(is_completed: true).where(failed: false).where(is_active: true) }
  scope :failed, -> { where(failed: true).where(is_active: true) }

  validates :user_id,
            :tracking_number,
            presence: true
  validates :tracking_number,
            uniqueness: true
end