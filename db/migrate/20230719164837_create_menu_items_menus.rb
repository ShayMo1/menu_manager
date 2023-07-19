class CreateMenuItemsMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items_menus do |t|
      t.belongs_to :menu, null: false, foreign_key: true
      t.belongs_to :menu_item, null: false, foreign_key: true

      t.timestamps
    end

    MenuItem.select(:id, :menu_id).find_each do |menu_item|
      MenuItemsMenu.create(menu_item_id: menu_item.id, menu_id: menu_item.menu_id)
    end
  end
end
