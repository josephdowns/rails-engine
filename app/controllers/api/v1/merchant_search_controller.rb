class Api::V1::MerchantSearchController < ApplicationController
  def index
    merchant = Merchant.where("name ILIKE ?", "%#{params[:name]}%").first
    render json: MerchantSerializer.new(merchant) if merchant
    render json: {data: {error: "Merchant not found"}} if !merchant
  end
end
