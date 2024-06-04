class Admin::InvoiceItemsController < ApplicationController

  def update
    @invoice_item = InvoiceItem.find(params[:id])
    if @invoice_item.update(invoice_item_params)
      redirect_to(admin_invoice_path(@invoice_item.invoice), alert: 'Item Status Updated!')
    end
  end

  private

  def invoice_item_params
    params.permit(:id, :status, :quantity, :unit_price, :invoice_id)
  end
end