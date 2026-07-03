class Refund < ApplicationRecord
  belongs_to :booking

  validates :amount, numericality: { greater_than: 0 }
end
