Spree::Product.class_eval do
  has_many :product_sales
  has_many :sales, through: :product_sales

  # def on_sale?(user = nil)
  #   return true if user && product_sales.active.exists?(user: user)
  #   product_sales.active.exists?(user: nil)
  # end

  def active_sale(user = nil)
    @active_sale ||= if user && product_sales.active.exists?(user: user)
                       product_sales.active.where(user: user).first
                     else
                       product_sales.active.where(user: nil).first
                     end
  end
end
