class Spree::SaleUser < ActiveRecord::Base
  belongs_to :sale
  belongs_to :user
end
