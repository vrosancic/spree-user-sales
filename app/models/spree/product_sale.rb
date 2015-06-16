module Spree
  class ProductSale < ActiveRecord::Base
    belongs_to :product
    belongs_to :sale
    belongs_to :user

    validates_presence_of :product_id, :sale_id, :active
  end
end
