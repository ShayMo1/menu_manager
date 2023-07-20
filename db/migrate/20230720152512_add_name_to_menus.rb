class AddNameToMenus < ActiveRecord::Migration[7.0]
  def change
    add_column :menus, :name, :string

    Menu.in_batches.each do |batch|
      batch.update_all('name = title')
    end
  end
end
