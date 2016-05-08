class Product < ActiveRecord::Base
  validates :sku, presence: true

  def margin
    100*(retail - wholesale)/(retail)
  end
end
