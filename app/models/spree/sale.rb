module Spree
  class Sale < ActiveRecord::Base
    has_many :product_sales

    has_many :taxons, class_name: 'Spree::SaleTaxon'
    has_many :products, class_name: 'Spree::SaleProduct'
    has_many :user_groups, class_name: 'Spree::SaleUserGroup'
    has_many :users, class_name: 'Spree::SaleUser'

    accepts_nested_attributes_for :taxons, allow_destroy: true
    accepts_nested_attributes_for :products, allow_destroy: true
    accepts_nested_attributes_for :user_groups, allow_destroy: true
    accepts_nested_attributes_for :users, allow_destroy: true

    enum sale_type: [:percent, :fixed]

    validates_presence_of :name, :start_date, :amount, :sale_type

    def active?
      return false if Time.zone.now < start_date
      return false if end_date && Time.zone.now > end_date
      true
    end
  end
end
