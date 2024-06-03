class AdminController < ApplicationController
  def index
    @merchants = Merchant.all
    @invoices_incomplete = Invoice.incomplete
    # pry
  end
end