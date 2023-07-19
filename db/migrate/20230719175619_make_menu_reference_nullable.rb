class MakeMenuReferenceNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :menu_items, :menu_id, true
  end
end
