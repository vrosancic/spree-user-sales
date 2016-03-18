Spree::Variant.class_eval do
  has_many :variant_sales
  has_many :sales, through: :variant_sales

  def price_in(currency)
    return sale_price_in(currency) if sale_price
    prices.select{ |price| price.currency == currency }.first || Spree::Price.new(variant_id: self.id, currency: currency)
  end

  def sale_price_in(currency)
    Spree::Price.new(variant_id: self.id, amount: sale_price, currency: currency)
  end

  def sale_price
    @sale_price ||= begin
      return if active_sale.nil?

      if active_sale.sale.percent?
        price - (price * active_sale.sale.amount / 100.0)
      else
        price - active_sale.sale.amount
      end
    end
  end

  def on_sale?(user = nil)
    active_sale(user).present?
  end

  def active_sale(user = Spree::User.current)
    @active_sale ||= if user && variant_sales.active.exists?(user: user)
                       variant_sales.active.where(user: user).first
                     else
                       variant_sales.active.where(user: nil).first
                     end
  end
end
