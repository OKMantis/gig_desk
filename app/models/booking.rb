class Booking < ApplicationRecord
  belongs_to :concert
  belongs_to :customer
end
