class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @enabled_items = @merchant.enabled_items
    @disabled_items = @merchant.disabled_items
    @top_five_items = @merchant.top_five_items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])

    if params[:status].present? && @item.update({status: params[:status]})
      redirect_to "/merchants/#{@merchant.id}/items"
    elsif @item.update(item_params)
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
      flash[:notice] = "Item Successfully Updated"
    else
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
      flash[:alert] = "Error: #{error_message(@item.errors)}"
    end
  end

  def new
  end

  def edit
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
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
    params.permit(:merchant_id, :name, :description, :unit_price, :status)
  end
end