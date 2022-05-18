require 'rails_helper'

describe "Merchants API" do
  it "sends a list of all merchants" do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response).to be_successful
    response_body = JSON.parse(response.body, symbolize_names: true)
    merchants = response_body[:data]
    expect(merchants.count).to eq(5)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "can get one merchant by id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to eq("#{id}")

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end

  xit "will not find a merchant with invalid id" do
    id = "64f"

    get "/api/v1/merchants/#{id}"

    expect(response).to_not be_successful
  end

  it "can display all items for a merchant" do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant1.id)
    item3 = create(:item, merchant_id: merchant1.id)

    get "/api/v1/merchants/#{merchant1.id}/items"

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]
binding.pry
    expect(response).to be_successful
    expect(merchant1.items.count).to eq(3)

  end
end
