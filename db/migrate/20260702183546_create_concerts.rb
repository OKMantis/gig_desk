class CreateConcerts < ActiveRecord::Migration[8.1]
  def change
    create_table :concerts do |t|
      t.string :title, null: false
      t.string :venue, null: false
      t.datetime :starts_at, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :tickets_available, null: false, default: 0

      t.timestamps
    end
  end
end
