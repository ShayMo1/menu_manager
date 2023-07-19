require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  before(:all) do
    @menu_item = MenuItem.new(name: nil, price: nil)
    @menu_item.valid?
  end

  it 'should require a name' do
    expect(@menu_item.errors.messages).to include(name: ['can\'t be blank'])
  end

  it 'should not allow duplicate names' do
    dup_menu_item = MenuItem.create_with(price: 10.00).find_or_create_by(name: 'Test Item')
    @menu_item.name = 'Test Item'
    @menu_item.valid?
    expect(@menu_item.errors.messages).to include(name: ['has already been taken'])
  end

  it 'should require a numeric price' do
    expect(@menu_item.errors.messages).to include(price: ['is not a number'])
  end

  it 'should not allow a negative price' do
    @menu_item.price = -1.0
    @menu_item.valid?
    expect(@menu_item.errors.messages).to include(price: ['must be greater than or equal to 0.0'])
  end

  it 'should be assignable to multiple menus' do
    MenuItemsMenu.delete_all
    menus = [Menu.find_or_create_by(title: 'Menu 1'), Menu.find_or_create_by(title: 'Menu 2')]
    menu_item = MenuItem.create_with(price: 10.00).find_or_create_by(name: 'Test Item')
    menu_item.menus << menus
    expect(MenuItemsMenu.count).to eq(2)
    expect(menu_item.menus.count).to eq(2)
  end
end
