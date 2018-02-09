class ChangeSaleDatesToDatetimes < ActiveRecord::Migration
  def up
    change_column :spree_sales, :start_date, :datetime
    change_column :spree_sales, :end_date, :datetime

    change_column :spree_variant_sales, :start_date, :datetime
    change_column :spree_variant_sales, :end_date, :datetime
  end

  def down
    change_column :spree_sales, :start_date, :date
    change_column :spree_sales, :end_date, :date

    change_column :spree_variant_sales, :start_date, :date
    change_column :spree_variant_sales, :end_date, :date
  end
end
