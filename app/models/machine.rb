class Machine < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings

  validates :name, :description, presence: true
  validates :description, length: { minimum: 5, maximum: 160 }

  scope :online, -> { where("visible = ?", true) }
  scope :offline, -> { where("visible = ?", false) }
end
