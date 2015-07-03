Spree::Variant.class_eval do
  def price_in(currency)
    return sale_price_in(currency) if sale_price
    prices.select{ |price| price.currency == currency }.first || Spree::Price.new(variant_id: self.id, currency: currency)
  end

  def sale_price_in(currency)
    Spree::Price.new(variant_id: self.id, amount: sale_price, currency: currency)
  end

  def sale_price
    @sale_price ||= count_sale_price
  end

  def count_sale_price
    product_sale = product.active_sale(Spree::User.current)
    return nil if product_sale.nil?

    if product_sale.sale.percent?
      return price - (price * product_sale.sale.amount / 100.0)
    else
      return price - product_sale.sale.amount
    end
  end
end
