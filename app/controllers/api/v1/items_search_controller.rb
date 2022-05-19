class Api::V1::ItemsSearchController < ApplicationController
  def index
    if params[:name] == ""
      render json: {data: {error: "Search cannot be empty"}}, status: 400
    elsif params[:name]
      items = Item.search_all(params[:name])
      render json: ItemSerializer.new(items) if items
      render json: {data: {error: "No items found"}} if !items
    else
      render json: {data: {error: "Please enter a search criteria"}}, status: 400
    end
  end
end
