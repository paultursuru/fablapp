class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :machine

  validates_uniqueness_of :machine_id, scope: [:start_time]
end
