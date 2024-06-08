class Merchants::InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices.distinct #required because there can be multiple invoices per invoice item so it would throw duplicates wihtout
  end
  
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @invoice_items = @invoice.invoice_items.joins(:item).where(items: { merchant_id: @merchant.id }).includes(:item)
    @total_revenue = @invoice.total_revenue_for_merchant(@merchant)
    @total_discounted_revenue = @invoice.total_discounted_revenue(@merchant)
  end
end