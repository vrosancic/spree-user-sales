class CreateSpreeSaleUserGroups < ActiveRecord::Migration
  def change
    create_table :spree_sale_user_groups do |t|
      t.integer :sale_id
      t.integer :user_group_id

      t.timestamps null: false
    end
  end
end
