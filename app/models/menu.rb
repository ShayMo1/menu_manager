class Menu < ApplicationRecord
  belongs_to :restaurant, optional: true
  has_many :menu_items_menus
  has_many :menu_items, through: :menu_items_menus

  validates :name, presence: true
end
