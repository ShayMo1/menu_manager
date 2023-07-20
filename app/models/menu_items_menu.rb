class MenuItemsMenu < ApplicationRecord
  belongs_to :menu
  belongs_to :menu_item

  validates :price, numericality: { greater_than_or_equal_to: 0.0, allow_nil: true }
end
