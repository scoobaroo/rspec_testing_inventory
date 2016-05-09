class Product < ActiveRecord::Base
  validates :sku, presence: true
  has_many :items

  def margin
    100*(retail - wholesale)/(retail)
  end

  def sell_through
    sold = (items.select { |item| item.status == 'sold' }).count
    (sold.to_d)/(items.count.to_d)
  end

end
