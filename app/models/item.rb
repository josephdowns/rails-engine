class Item < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name

  def self.search_by_name(params)
    where("name ILIKE ?", "%#{params}%")
  end

  def self.search_by_price(min, max)
    if min == 0
      where("unit_price <= ?", max)
      .order(:name)
    elsif max == 0
      where("unit_price >= ?", min)
      .order(:name)
    else
      where("unit_price BETWEEN ? AND ?", min, max)
      .order(:name)
    end
  end


end
