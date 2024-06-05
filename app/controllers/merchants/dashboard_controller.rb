class Merchants::DashboardController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @customers = @merchant.top_five_customers
  end
end