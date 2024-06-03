class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @enabled_items = @merchant.enabled_items
    @disabled_items = @merchant.disabled_items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:item_id])
    @merchant = Merchant.find(params[:merchant_id])
    # pry

    if params[:status].present? && @item.update({status: params[:status]})
      # pry
      redirect_to "/merchants/#{@merchant.id}/items"
    elsif @item.update(item_params)
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
    else
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
      flash[:alert] = "Error: #{error_message(@item.errors)}"
    end
  end

  def new
  end

  def create
    params[:status] = 1
    item = Item.new(item_params)
    
    if item.save
      redirect_to merchant_items_path
    else
      flash[:alert] = "Error: #{error_message(item.errors)}"
      render :new
    end
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :status)
  end
end