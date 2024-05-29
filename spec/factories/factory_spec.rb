require 'rails_helper'

RSpec.describe 'FactoryBot' do
  it 'has a valid customer factory' do
    expect(build(:customer)).to be_valid
  end

  it 'create a custoemr with a specific first name' do
    customer = create(:customer, first_name: 'Alice')
    expect(customer.first_name).to eq('Alice')
  end
end