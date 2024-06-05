class AdminController < ApplicationController
  def index
    @merchants = Merchant.all
    @invoices_incomplete = Invoice.incomplete
    @customers = Customer.all
  end
end