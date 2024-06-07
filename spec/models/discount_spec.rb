require "rails_helper"

RSpec.describe Discount do

  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :percentage}
    it { should validate_numericality_of(:percentage).only_integer.is_greater_than_or_equal_to(1).is_less_than_or_equal_to(100) }
    it {should validate_presence_of :threshold}
    it { should validate_numericality_of(:threshold).only_integer.is_greater_than_or_equal_to(0) }
  
  end

  describe "relationships" do
    it {should belong_to :merchant}
  end
end