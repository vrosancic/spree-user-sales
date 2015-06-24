Spree::Variant.class_eval do
  alias_method :orig_price_in, :price_in

  def price_in(currency)
    return orig_price_in(currency) unless false && sale_price
    Spree::Price.new(variant_id: self.id, amount: sale_price, currency: currency)
  end

  def default_price
    if false && sale_price
      Spree::Price.new(variant_id: self.id, amount: sale_price, currency: currency)
    else
      Spree::Price.unscoped { super }
      # super
    end
  end

  def sale_price
    @sale_price ||= count_sale_price
  end

  def count_sale_price
    sale = product.active_sale(User.current)
    return nil if sale.nil?

    if sale.percent?
      return price - (price * sale.amount)
    else
      return price - sale.amount
    end
  end
end
