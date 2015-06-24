module Spree
  module Admin
    class SalesController < Spree::Admin::ResourceController
      def index
        @sales = Spree::Sale.all
      end

      def new
        @sale = Spree::Sale.new
      end

      def create
        binding.pry
        @sale = SaleCreator.create(sale_params)
        respond_with @sale
      end

      private

      def sale_params
        params.require(:sale).permit(:name, :description, :amount, :sale_type,
                                     :start_date, :end_date,
                                     taxon_ids: [], product_ids: [],
                                     user_group_ids: [], user_ids: [])
      end

    end
  end
end
