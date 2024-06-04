class InvoiceItemsController < ApplicationController
  def update
    @invoice_item = InvoiceItem.find(params[:id])
    if @invoice_item.update(invoice_item_params)
      redirect_to(merchant_invoice_path(@invoice_item.item.merchant_id, @invoice_item.invoice_id), alert: 'Item Status Updated!')
    end
  end

  private

  def invoice_item_params
    params.permit(:id, :status, :quantity, :unit_price, :item_id, :invoice_id)
  end
end
