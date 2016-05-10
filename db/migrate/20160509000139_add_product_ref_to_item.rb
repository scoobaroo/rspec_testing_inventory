class AddProductRefToItem < ActiveRecord::Migration
  def change
    add_reference :items, :product, index: true, foreign_key: true
  end
end
