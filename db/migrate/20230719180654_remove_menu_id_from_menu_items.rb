class RemoveMenuIdFromMenuItems < ActiveRecord::Migration[7.0]
  # This should not be ran until the previous migrations to create and backfill menu_items_menus have been validated
  def change
    remove_column :menu_items, :menu_id
  end
end
