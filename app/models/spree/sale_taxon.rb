class Spree::SaleTaxon < ActiveRecord::Base
  belongs_to :sale
  belongs_to :taxon
end
