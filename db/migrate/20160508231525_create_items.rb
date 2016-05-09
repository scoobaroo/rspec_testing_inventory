class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :size
      t.string :color
      t.string :status

      t.timestamps null: false
    end
  end
end
