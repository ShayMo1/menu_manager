class CreateMenuItems < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.decimal :price, precision: 6, scale: 2
      t.belongs_to :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
