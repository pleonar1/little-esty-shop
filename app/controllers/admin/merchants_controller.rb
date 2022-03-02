class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
      @merchant = Merchant.find(params[:id])
      @merchant.update(status: params[:status])
      redirect_to "/admin/merchants"
  end

  def create
    Merchant.create!(merchant_params)
    redirect_to "/admin/merchants"
  end

  private
  def merchant_params
    params.permit(:name, :status)
  end

end
