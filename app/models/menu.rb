class Menu < ApplicationRecord
  has_many :menu_items

  validates :title, presence: true
end
