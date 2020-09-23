class Machine < ApplicationRecord
  has_many :bookings
  has_many :users, through: :bookings

  validates :name, :description, presence: true

  scope :online, -> { where("visible = ?", true) }
  scope :offline, -> { where("visible = ?", false) }
end
