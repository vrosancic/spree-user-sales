module Spree
  class VariantSale < ActiveRecord::Base
    belongs_to :variant
    belongs_to :sale
    belongs_to :user

    validates_presence_of :variant_id, :sale_id

    scope :active, -> { where('? >= start_date AND (end_date IS NULL OR ? < end_date)', Time.zone.today, Time.zone.today) }
  end
end
