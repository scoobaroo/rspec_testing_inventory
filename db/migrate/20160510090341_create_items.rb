class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :color
      t.string :status
      t.string :size

      t.timestamps null: false
    end
  end
end
