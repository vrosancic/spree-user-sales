class SaleCreator
  attr_reader :sale_params, :sale

  def self.create(sale_params, existing_sale = nil)
    new(sale_params, existing_sale).create
  end

  def initialize(sale_params, existing_sale)
    @sale_params = sale_params
    @sale = existing_sale.nil? ? Spree::Sale.new(sale_params) : existing_sale
  end

  def create
    if can_be_created?
      if products.any?
        put_products_on_sale if save_sale
      else
        sale.errors.add(:base, "You must specify at least one taxon or product.")
      end
    else
      sale.errors.add(:base, "Some of selected products in that date range are already on sale.")
    end
    sale
  end

  private

  def can_be_created?
    # if date ranges (start and end date) of 2 sales don't overlap
    # https://stackoverflow.com/questions/325933/determine-whether-two-date-ranges-overlap/325964#325964
    query = Spree::ProductSale.joins(:sale)
            .where(product: products, user: users)
            .where("(? IS NULL OR spree_sales.start_date <= ?) AND (spree_sales.end_date
                    IS NULL OR spree_sales.end_date >= ?)", sale.end_date, sale.end_date, sale.start_date)

    query = query.where.not(sale: sale) if sale.persisted?

    !query.exists?
  end

  def save_sale
    sale.persisted? ? sale.update(sale_params) : sale.save
  end

  def put_products_on_sale
    Spree::ProductSale.destroy_all(sale: sale) if sale.persisted?
    products.each do |product|
      if users.nil?
        product.product_sales.create(sale: sale, user: nil, start_date: sale.start_date, end_date: sale.end_date)
      else
        users.each do |user|
          product.product_sales.create(sale: sale, user: user, start_date: sale.start_date, end_date: sale.end_date)
        end
      end
    end
  end

  def products
    @products ||= set_products
  end

  def users
    @users ||= set_users
  end

  def set_products
    product_ids = []
    product_ids.concat sale_params[:product_ids]
    if sale_params[:taxon_ids].any?
      product_ids.concat Spree::ProductsTaxon.where(taxon_id: sale_params[:taxon_ids]).pluck(:product_id)
    end
    Spree::Product.where(id: product_ids)
  end

  def set_users
    user_ids = []
    user_ids.concat sale_params[:user_ids]
    if sale_params[:user_group_ids].any?
      user_ids.concat UserGroupMembership.where(user_group_id: sale_params[:user_group_ids]).pluck(:user_id)
    end
    users = User.where(id: user_ids)
    users.any? ? users : nil
  end
end
