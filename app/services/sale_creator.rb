class SaleCreator
  attr_reader :sale_params, :products, :users

  def initialize(sale_params, product_ids, user_ids)
    @sale_params = sale_params
    @products = Spree::Product.where(id: product_ids)
    @users = User.where(id: user_ids)
  end

  def create
    sale = Spree::Sale.new(sale_params)

    if can_be_created?(sale)
      put_products_on_sale(sale) if sale.save
    else
      sale.errors.add(:base, "Some of products in that date range are already on sale.")
    end
    sale
  end

  private

  def can_be_created?(sale)
    # if date ranges (start and end date) of 2 sales don't overlap
    # https://stackoverflow.com/questions/325933/determine-whether-two-date-ranges-overlap/325964#325964
    !Spree::ProductSale.joins(:sale)
      .where(product: products, user: users)
      .where("(? IS NULL OR spree_sales.start_date <= ?) AND (spree_sales.end_date
              IS NULL OR spree_sales.end_date >= ?)", sale.end_date, sale.end_date, sale.start_date)
      .exists?
  end

  def put_products_on_sale(sale)
    products.each do |product|
      if users.nil?
        product.product_sales.create(sale: sale, user: nil)
      else
        users.each do |user|
          product.product_sales.create(sale: sale, user: user)
        end
      end
    end
  end
end
