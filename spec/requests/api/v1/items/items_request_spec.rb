require 'rails_helper'

describe "Items API" do

  it "sends a list of all items" do
    create_list(:item, 5)
    get '/api/v1/items'

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(response).to be_successful

    items.each do |item|
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

  it "send one item by id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(response).to be_successful

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

  it "can update an item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "Special Spork" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Special Spork")
  end

  it "fails to update an item" do
    item = create(:item)
    id = item.id
    item_params = { name: "" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    expect(response).to_not be_successful
  end

  it "can create a new item" do
    merchant = create(:merchant)
    item_params = ({
              name: "Special Spork",
              description: "A spork for all your needs!",
              unit_price: 1300,
              merchant_id: merchant.id
      })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate({item: item_params})
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can destroy an book" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "sends the item's merchant" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    response_body = JSON.parse(response.body, symbolize_names: true)
    page = response_body[:data]

    expect(response).to be_successful
    expect(page).to have_key(:attributes)
    expect(page[:attributes]).to have_key(:name)
    expect(page[:attributes][:name]).to be_a(String)

  end
end
