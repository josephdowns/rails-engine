require 'rails_helper'

describe "Items API" do
  before(:each) do
    create_list(:item, 5)
    get '/api/v1/items'

    @response_body = JSON.parse(response.body, symbolize_names: true)
    @items = @response_body[:data]
  end
  it "sends a list of all items" do

    expect(response).to be_successful

    @items.each do |item|
      expect(item).to have_key(:id)
      expect(item).to have_key(:attributes)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end

  end
end
