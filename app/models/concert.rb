class Concert < ApplicationRecord
  has_many :bookings, dependent: :destroy

  validates :title, :venue, :starts_at, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :tickets_available, numericality: { greater_than_or_equal_to: 0 }

  def upcoming?
    starts_at > Time.current
  end
end
