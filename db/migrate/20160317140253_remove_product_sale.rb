class RemoveProductSale < ActiveRecord::Migration
  def up
    drop_table :spree_product_sales
  end

  def down
    create_table :spree_product_sales do |t|
      t.integer :product_id
      t.integer :user_id
      t.integer :sale_id
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
