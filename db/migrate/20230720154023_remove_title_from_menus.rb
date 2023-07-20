class RemoveTitleFromMenus < ActiveRecord::Migration[7.0]
  # This should not be ran until the previous migration to add name to menus and backfill from title has been validated
  def change
    remove_column :menus, :title
  end
end
