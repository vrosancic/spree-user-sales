module Spree
  class Sale < ActiveRecord::Base
    has_many :product_sales, dependent: :destroy

    has_many :sale_taxons, dependent: :destroy
    has_many :taxons, through: :sale_taxons
    has_many :sale_products, dependent: :destroy
    has_many :products, through: :sale_products
    has_many :sale_user_groups, dependent: :destroy
    has_many :user_groups, through: :sale_user_groups
    has_many :sale_users, dependent: :destroy
    has_many :users, through: :sale_users

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
