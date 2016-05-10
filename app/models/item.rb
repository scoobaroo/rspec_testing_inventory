class Item < ActiveRecord::Base
  validates :status, presence: true
end
