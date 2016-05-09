class AddProductRefToItem < ActiveRecord::Migration
  def change
    add_reference :items, :product, index: true
    add_foreign_key :items, :products
  end
end
