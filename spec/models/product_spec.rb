require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#margin' do

    let :product do
      FactoryGirl.create(:product, wholesale: (10.00).to_d, retail: (15.00).to_d)
    end

    it "returns a BigDecimal value" do
      expect(product.margin).to be_instance_of BigDecimal
    end

    it "calculates the profit margin correctly" do
      correct_margin = 100*(1.to_d)/(3.to_d)
      expect(product.margin).to(eq correct_margin)
    end
  end

  describe '#sell_through' do
    let :product do
      FactoryGirl.create(:product)
    end

    before do
      5.times do
        FactoryGirl.create(:item, product: product, status: 'sold')
      end
      5.times do
        FactoryGirl.create(:item, product: product, status: 'unsold')
      end
    end

    it "returns a BigDecimal value" do
      expect(product.sell_through).to be_instance_of BigDecimal
    end

    it "calculates correct sell-through" do
      correct_sell_through = (1.to_d)/(2.to_d)
      expect(product.sell_through).to(eq(correct_sell_through))
    end
  end

end
