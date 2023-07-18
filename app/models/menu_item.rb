class MenuItem < ApplicationRecord
  belongs_to :menu

  validates :name, presence: true
  validates :menu, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.0 }
end
