class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :machine

  validates_uniqueness_of :machine_id, scope: [:start_time]

  scope :in_the_future, -> { where("start_time > ?", DateTime.now) }
  scope :in_the_past, -> { where("start_time < ?", DateTime.now) }
  scope :is_today, -> { where("start_time < ?", (Time.now + 1.days).change(hour: 8)) }
  scope :after_today, -> { where("start_time > ?", (Time.now + 1.days).change(hour: 8)) }
  scope :before_today, -> { where("start_time < ?", (Time.now).change(hour: 8)) }
  scope :last_week, -> { where("start_time > ?", (Time.now - 8.days).change(hour: 8)) }
  scope :is_past_today, -> { where("start_time > ?", (Time.now).change(hour: 8)) }
end
