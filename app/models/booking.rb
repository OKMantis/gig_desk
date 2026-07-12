class Booking < ApplicationRecord
  belongs_to :concert
  belongs_to :customer
  has_one :refund, dependent: :destroy

  STATUSES = %w[confirmed cancelled].freeze

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: STATUSES }

  def confirmed? = status == "confirmed"
  def cancelled? = status == "cancelled"
end
