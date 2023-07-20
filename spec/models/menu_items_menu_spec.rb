require 'rails_helper'

RSpec.describe MenuItemsMenu, type: :model do
  before(:all) do
    MenuItemsMenu.delete_all
    menu = Menu.find_or_create_by(name: 'Test Menu')
    menu_item = MenuItem.find_or_create_by(name: 'Test Item')
    @menu_items_menu = MenuItemsMenu.create(menu_id: menu.id, menu_item_id: menu_item.id)
    @menu_items_menu.valid?
  end

  it 'should require a numeric price' do
    @menu_items_menu.price = 'one dollar'
    @menu_items_menu.valid?
    expect(@menu_items_menu.errors.messages).to include(price: ['is not a number'])
  end

  it 'should not allow a negative price' do
    @menu_items_menu.price = -1.0
    @menu_items_menu.valid?
    expect(@menu_items_menu.errors.messages).to include(price: ['must be greater than or equal to 0.0'])
  end
end