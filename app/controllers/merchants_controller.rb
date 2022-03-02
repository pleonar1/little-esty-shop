class MerchantsController < ApplicationController

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(name: params[:merchant][:name])
    flash[:notice] = "Merchant Successfully Updated."
    redirect_to "/admin/merchants/#{merchant.id}"
  end
end
