class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :machine

  validates_uniqueness_of :machine_id, scope: [:start_time]

  scope :in_the_future, -> { where("start_time > ?", DateTime.now) }
  scope :is_today, -> { where(start_time: Date.today) }
  scope :after_today, -> { where("start_time > ?", Date.today) }
end
