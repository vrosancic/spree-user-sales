class CreateSpreeSaleProducts < ActiveRecord::Migration
  def change
    create_table :spree_sale_products do |t|
      t.integer :sale_id
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
