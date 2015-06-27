Spree::Variant.class_eval do
  alias_method :orig_price_in, :price_in

  def price_in(currency)
    return orig_price_in(currency) unless sale_price
    Spree::Price.new(variant_id: self.id, amount: sale_price, currency: currency)
  end

  def sale_price
    @sale_price ||= count_sale_price
  end

  def count_sale_price
    product_sale = product.active_sale(User.current)
    return nil if product_sale.nil?

    if product_sale.sale.percent?
      return price - (price * product_sale.sale.amount)
    else
      return price - product_sale.sale.amount
    end
  end
end
