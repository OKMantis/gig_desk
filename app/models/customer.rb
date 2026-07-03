class Customer < ApplicationRecord
  has_many :bookings, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :credit_balance, numericality: { greater_than_or_equal_to: 0 }

end
