class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true, null: false
      t.references :restaurant, foreign_key: true, null: false
      t.decimal :price, precision: 10, scale: 2
      t.timestamps
    end
  end
end
