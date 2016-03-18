class CreateSpreeSaleVariants < ActiveRecord::Migration
  def change
    create_table :spree_sale_variants do |t|
      t.integer :sale_id
      t.integer :variant_id

      t.timestamps null: false
    end
  end
end
