class Menu < ApplicationRecord
  belongs_to :restaurant, optional: true
  has_many :menu_items

  validates :title, presence: true
end
