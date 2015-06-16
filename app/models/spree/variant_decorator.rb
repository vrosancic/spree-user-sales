Spree::Variant.class_eval do
  alias_method :orig_price_in, :price_in

  def price_in(currency)
    return orig_price_in(currency) unless product.on_sale?(User.current)
    Spree::Price.new(variant_id: self.id, amount: sale_price, currency: currency)
  end

  def sale_price
    sale = product.active_sale(User.current)
    return price if sale.nil?

    if sale.percent?
      return price - (price * sale.amount)
    else
      return price - sale.amount
    end
  end
end
