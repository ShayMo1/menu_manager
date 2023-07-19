class AddRestaurantRefToMenus < ActiveRecord::Migration[7.0]
  def change
    add_reference :menus, :restaurant, null: true, foreign_key: true
  end
end
