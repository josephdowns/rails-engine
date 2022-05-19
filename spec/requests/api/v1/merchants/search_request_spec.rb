require 'rails_helper'

RSpec.describe "Search Merchants API" do
  before(:each) do
    Merchant.create!(name: "The Brown Fox")
  end

  it "can find a single merchant" do
    get "/api/v1/merchants/find?name=Fox"

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchants = response_body[:data]

    merchants.each do |merchant|
      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to eq("The Brown Fox")
    end

  end
end
