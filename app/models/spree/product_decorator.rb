Spree::Product.class_eval do
  has_many :product_sales
  has_many :sales, through: :product_sales

  def on_sale?(user = nil)
    return true if user && product_sales.exists?(active: true, user: user)
    product_sales.exists?(active: true, user: nil)
  end

  def active_sale(user = nil)
    if user && product_sales.exists?(active: true, user: user)
      product_sales.where(active: true, user: user).first
    else
      product_sales.where(active: true, user: nil).first
    end
  end
end
