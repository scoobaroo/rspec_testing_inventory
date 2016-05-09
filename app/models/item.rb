class Item < ActiveRecord::Base
  validates :status, presence: true
  belongs_to :product
end
