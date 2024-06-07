class Merchants::DiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])

    Discount.create(name: params[:name], percentage: params[:percentage], threshold: params[:threshold], merchant: @merchant)
    redirect_to merchant_discounts_path(@merchant.id)
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
    @discount.destroy

    redirect_to merchant_discounts_path(@merchant.id), notice: 'Discount was successfully deleted.'
  end
end