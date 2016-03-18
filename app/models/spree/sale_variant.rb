class Spree::SaleVariant < ActiveRecord::Base
  belongs_to :sale
  belongs_to :variant
end
