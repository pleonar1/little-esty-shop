class MerchantBulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.create
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    new_bulk_discount = merchant.bulk_discounts.create(bulk_discount_params)
    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

    private

      def bulk_discount_params
        params.require(:bulk_discount).permit(:quantity, :discount, :merchant_id)
      end
end
