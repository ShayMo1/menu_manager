require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  before(:all) do
    @menu_item = MenuItem.new(name: nil)
    @menu_item.valid?
  end

  it 'should require a name' do
    expect(@menu_item.errors.messages).to include(name: ['can\'t be blank'])
  end

  it 'should not allow duplicate names' do
    dup_menu_item = MenuItem.find_or_create_by(name: 'Test Item')
    @menu_item.name = 'Test Item'
    @menu_item.valid?
    expect(@menu_item.errors.messages).to include(name: ['has already been taken'])
  end

  it 'should be assignable to multiple menus' do
    MenuItemsMenu.delete_all
    menus = [Menu.find_or_create_by(name: 'Menu 1'), Menu.find_or_create_by(name: 'Menu 2')]
    menu_item = MenuItem.find_or_create_by(name: 'Test Item')
    menu_item.menus << menus
    expect(MenuItemsMenu.count).to eq(2)
    expect(menu_item.menus.count).to eq(2)
  end
end
