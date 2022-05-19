class Api::V1::ItemsSearchController < ApplicationController
  def index
    items = Item.where("name ILIKE ?", "%#{params[:name]}%")
    render json: ItemSerializer.new(items) if items
    render json: {data: {error: "No items found"}} if !items
  end
end
