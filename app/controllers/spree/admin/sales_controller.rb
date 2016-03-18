module Spree
  module Admin
    class SalesController < Spree::Admin::ResourceController
      before_action :prepare_array_params, only: [:create, :update]

      def index
        @sales = Spree::Sale.all
      end

      def new
        @sale = Spree::Sale.new
      end

      def create
        @sale = SaleCreator.create(sale_params)
        respond_with @sale, location: polymorphic_url([:admin, :sales])
      end

      def edit
        set_sale
      end

      def update
        set_sale
        @sale = SaleCreator.create(sale_params, @sale)
        respond_with @sale, location: polymorphic_url([:admin, :sales])
      end

      private

      def set_sale
        @sale = Spree::Sale.find(params[:id])
      end

      def sale_params
        params.require(:sale).permit(:name, :description, :amount, :sale_type,
                                     :start_date, :end_date,
                                     taxon_ids: [], product_ids: [], variant_ids: [],
                                     user_group_ids: [], user_ids: [])
      end

      def prepare_array_params
        [:taxon_ids, :product_ids, :user_group_ids, :user_ids, :variant_ids].each do |key|
          if params[:sale][key].present?
            params[:sale][key] = params[:sale][key].split(',')
          else
            params[:sale][key] = []
          end
        end
      end
    end
  end
end
