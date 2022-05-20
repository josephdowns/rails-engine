class Api::V1::ItemsSearchController < ApplicationController
  def index
    if params[:name] == ""
      render json: {data: {error: "Search cannot be empty"}}, status: 400
    elsif params[:min_price] == "" && params[:max_price] == ""
      render json: {data: {error: "Search cannot be empty"}}, status: 400
    elsif params[:name]
      items = Item.search_by_name(params[:name])
      render json: ItemSerializer.new(items) if items
      render json: {data: {error: "No items found"}} if !items
    elsif params[:min_price] || params[:max_price]
      items = Item.search_by_price(params[:min_price].to_i, params[:max_price].to_i)
      render json: ItemSerializer.new(items) if items
      render json: {data: {error: "No items found"}} if !items
    else
      render json: {data: {error: "Please enter a search criteria"}}, status: 400
    end
  end
end
