class CreateCustomers < ActiveRecord::Migration[8.1]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.decimal :credit_balance, precision: 10, scale: 2, null: false, default: 0

      t.timestamps
    end
  end
end
