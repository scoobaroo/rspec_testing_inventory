class Item < ActiveRecord::Base
  belongs_to :product

  validates :status, presence: true

end
