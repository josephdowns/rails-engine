class Api::V1::MerchantSearchController < ApplicationController
  def index
    if params[:name] == ""
      render json: {data: {error: "Search cannot be empty"}}, status: 400
    elsif params[:name]
      merchant = Merchant.search(params[:name])
      render json: MerchantSerializer.new(merchant) if merchant
      render json: {data: {error: "Merchant not found"}} if !merchant
    else
      render json: {data: {error: "Please enter a search criteria"}}, status: 400
    end
  end
end
