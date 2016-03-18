Spree::Product.class_eval do
  has_many :variant_sales, through: :variants_including_master

  def on_sale?(user = nil)
    return true if user && variant_sales.active.exists?(user: user)
    variant_sales.active.exists?(user: nil)
  end
end
