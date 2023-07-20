class AddPriceToMenuItemsMenus < ActiveRecord::Migration[7.0]
  def change
    add_column :menu_items_menus, :price, :decimal, precision: 6, scale: 2

    MenuItem.find_each do |menu_item|
      menu_item.menu_items_menus.update_all(price: menu_item.price)
    end
  end
end
