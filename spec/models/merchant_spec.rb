require "rails_helper"

RSpec.describe Merchant do
  it {should validate_presence_of :name}
  
  it {should have_many :items}
  it {should have_many(:invoice_items).through(:items)}
  it {should have_many(:invoices).through(:items)}
  it {should have_many(:transactions).through(:items)}
  it {should have_many(:customers).through(:invoices)}

  before :each do

  end
  describe "instance methods" do

  end
end