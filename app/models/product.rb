class Product < ActiveRecord::Base
  validates :sku, presence: true
  has_many :items

  def margin
    100*(retail - wholesale)/(retail)
  end
end
