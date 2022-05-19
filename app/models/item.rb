class Item < ApplicationRecord
  belongs_to :merchant

  def self.search_all(params)
    Item.where("name ILIKE ?", "%#{params}%")
  end
end
