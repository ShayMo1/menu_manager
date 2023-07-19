class MenuItem < ApplicationRecord
  has_many :menu_items_menus
  has_many :menus, through: :menu_items_menus

  validates :name, presence: true, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0.0 }
end
