class AddVariantSale < ActiveRecord::Migration
  def change
    create_table :spree_variant_sales do |t|
      t.integer :variant_id
      t.integer :user_id
      t.integer :sale_id
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
