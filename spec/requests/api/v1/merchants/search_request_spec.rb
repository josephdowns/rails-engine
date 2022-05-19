require 'rails_helper'

RSpec.describe "Search Merchants API" do
  before(:each) do
    Merchant.create!(name: "The Brown Fox")
  end

  it "can find a single merchant" do
    get "/api/v1/merchants/find?name=Fox"

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to eq("The Brown Fox")

  end

  it "returns an error when blank" do
    get "/api/v1/merchants/find"

    response_body = JSON.parse(response.body, symbolize_names: true)
    body = response_body[:data]

    expect(response).to_not be_successful
    expect(body[:error]).to eq("Please enter a search criteria")
  end

  it "returns an error when invalid search" do
    get "/api/v1/merchants/find?name="

    response_body = JSON.parse(response.body, symbolize_names: true)
    body = response_body[:data]

    expect(response).to_not be_successful
    expect(body[:error]).to eq("Search cannot be empty")
  end
end
