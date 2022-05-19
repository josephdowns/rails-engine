class Item < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name

  def self.search_items(params)
    Item.where("name ILIKE ?", "%#{params}%")
  end
end
