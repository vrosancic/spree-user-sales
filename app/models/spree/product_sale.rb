module Spree
  class ProductSale < ActiveRecord::Base
    belongs_to :product
    belongs_to :sale
    belongs_to :user

    validates_presence_of :product_id, :sale_id
    # validates_uniqueness_of :active, if: :active?, scope: [:product, :user]
  end
end
