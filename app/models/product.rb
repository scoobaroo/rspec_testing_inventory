class Product < ActiveRecord::Base
  has_many :items, dependent: :destroy

  validates :sku, presence: true

  def margin
    100*(retail - wholesale)/(retail)
  end

  def sell_through
    total_items = items.count
    items_sold = items.where(status: "sold").count
    (items_sold.to_d)/(total_items.to_d)
  end

end
