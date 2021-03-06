class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings, dependent: :destroy
  has_many :machines, through: :bookings
  has_many :formations, dependent: :destroy

  enum role: [:student, :admin]
  after_initialize { self.role ||= :student if self.new_record? }
end
