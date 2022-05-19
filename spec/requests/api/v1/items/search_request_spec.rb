require 'rails_helper'

RSpec.describe "Search Items API" do
  before(:each) do
    item1 = create(:item, name: "The Ring")
    item2 = create(:item, name: "Auring")
    item3 = create(:item, name: "Ring Mushroom")
    item4 = create(:item, name: "Special Spork")
  end

  it "can find all items" do
    get "/api/v1/items/find_all?name=ring"

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name].downcase.include?("ring")).to be(true)
      expect(item[:attributes][:name].downcase.include?("spork")).to be(false)
    end

  end

  it "returns an error when blank" do
    get "/api/v1/items/find_all"

    response_body = JSON.parse(response.body, symbolize_names: true)
    body = response_body[:data]

    expect(response).to_not be_successful
    expect(body[:error]).to eq("Please enter a search criteria")
  end

  it "returns an error when invalid" do
    get "/api/v1/items/find_all?name="

    response_body = JSON.parse(response.body, symbolize_names: true)
    body = response_body[:data]

    expect(response).to_not be_successful
    expect(body[:error]).to eq("Search cannot be empty")
  end
end
