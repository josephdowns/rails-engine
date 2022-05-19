class Api::V1::SearchController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.where("name ILIKE ?", "%#{params[:name]}"))
  end
end
