class CreateBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :bookings do |t|
      t.references :concert, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.string :status, null: false, default: 0

      t.timestamps
    end
  end
end
