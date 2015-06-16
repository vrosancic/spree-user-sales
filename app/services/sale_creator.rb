class SaleCreator
  attr_reader :sale, :products, :users

  def initialize(sale, products, users)
    @sale = sale
    @products = products
    @users = users
  end

  def create
  end
end
