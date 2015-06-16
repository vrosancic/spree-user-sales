module Spree
  class Sale < ActiveRecord::Base
    has_many :product_sales

    enum sale_type: [:percent, :fixed]

    validates_presence_of :name, :start_date, :amount, :sale_type
  end
end
