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
    @discount = @merchant.discounts.new(name: params[:name], percentage: params[:percentage], threshold: params[:threshold], merchant: @merchant)
    # Discount.save(name: params[:name], percentage: params[:percentage], threshold: params[:threshold], merchant: @merchant)
    if @discount.save
      redirect_to merchant_discounts_path(@merchant.id)
    else
      flash.now[:alert] = 'Failed to create discount'
      render :new
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
    
    if @discount.eligible_and_pending? == true
      flash[:alert] = "Discount can not be deleted, there are pending invoices associated"
    else
      @discount.destroy
      flash[:notice] = "Discount was successfully deleted"
    end 
    redirect_to merchant_discounts_path(@merchant.id)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
    
  end
  
  def update
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])

    if @discount.update(discount_params) && @discount.eligible_and_pending? == false
      redirect_to merchant_discount_path(@merchant, @discount), notice: 'Discount was successfully edited.'
    else
      flash.now[:alert] = 'Failed to update discount'
      render :new
    end
  end

  private
  
  def discount_params
    params.require(:discount).permit(:name, :percentage, :threshold)
  end
end
