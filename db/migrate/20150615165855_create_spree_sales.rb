class CreateSpreeSales < ActiveRecord::Migration
  def change
    create_table :spree_sales do |t|
      t.string :name
      t.text :description
      t.decimal :amount, precision: 10, scale: 2
      t.integer :sale_type
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
