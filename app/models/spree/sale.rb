module Spree
  class Sale < ActiveRecord::Base
    has_many :variant_sales, dependent: :destroy

    has_many :sale_taxons, dependent: :destroy
    has_many :taxons, through: :sale_taxons
    has_many :sale_products, dependent: :destroy
    has_many :products, through: :sale_products
    has_many :sale_user_groups, dependent: :destroy
    has_many :user_groups, through: :sale_user_groups
    has_many :sale_users, dependent: :destroy
    has_many :users, through: :sale_users
    has_many :sale_variants, dependent: :destroy
    has_many :variants, through: :sale_variants

    enum sale_type: [:percent, :fixed]

    validates_presence_of :name, :start_date, :amount, :sale_type
    validate :end_date_greater_than_start_date?

    def active?
      return false if Time.zone.now < start_date
      return false if end_date && Time.zone.now > end_date
      true
    end

    def end_date_greater_than_start_date?
      return if end_date.blank? || end_date > start_date

      errors.add(:end_date, 'must be greater than start date')
    end
  end
end
