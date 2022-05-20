require 'rails_helper'

RSpec.describe Item do
  describe "attributes" do
    it { should validate_presence_of(:name) }
    it { should belong_to :merchant }
  end

  describe "methods" do
    it "finds items by name" do
      create(:item, name: "Booty Forks")
      create(:item, name: "Booty Brush")
      create(:item, name: "Bootylicious Licorice")
      create(:item, name: "Vertical Tacos")

      array = Item.search_by_name("booty")

      expect(array.count).to eq(3)
    end

    it "finds items by price" do
      create(:item, name: "Booty Forks", unit_price: 100)
      create(:item, name: "Booty Brush", unit_price: 150)
      create(:item, name: "Bootylicious Licorice", unit_price: 200)
      create(:item, name: "Vertical Tacos", unit_price: 100)

      min = Item.search_by_price(150, 0)
      max = Item.search_by_price(0, 150)
      betwixt = Item.search_by_price(100, 200)

      expect(min.count).to eq(2)
      expect(max.count).to eq(3)
      expect(betwixt.count).to eq(4)
    end
  end
end
