class Merchant < ApplicationRecord
  has_many :items

  def self.search(params)
    Merchant.where("name ILIKE ?", "%#{params}%").first
  end
end
