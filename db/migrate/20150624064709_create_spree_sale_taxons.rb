class CreateSpreeSaleTaxons < ActiveRecord::Migration
  def change
    create_table :spree_sale_taxons do |t|
      t.integer :sale_id
      t.integer :taxon_id

      t.timestamps null: false
    end
  end
end
