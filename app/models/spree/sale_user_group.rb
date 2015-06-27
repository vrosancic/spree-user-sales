class Spree::SaleUserGroup < ActiveRecord::Base
  belongs_to :sale
  belongs_to :user_group
end
