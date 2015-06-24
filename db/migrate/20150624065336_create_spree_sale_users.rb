class CreateSpreeSaleUsers < ActiveRecord::Migration
  def change
    create_table :spree_sale_users do |t|
      t.integer :sale_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
