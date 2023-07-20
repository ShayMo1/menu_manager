require 'rails_helper'

RSpec.describe FileImporter do
  before(:all) do
    MenuItemsMenu.delete_all
    MenuItem.delete_all
    Menu.delete_all
    Restaurant.delete_all

    @log = FileImporter.new('spec/fixtures/import_test.json').import
  end

  it 'should log an error when the provided file doesn\'t exist' do
    log = FileImporter.new('nonextant_file.json').import
    expect(log).to include('Failure: The provided file does not exist.')
  end

  it 'should log an error when the file doesn\'t include valid JSON' do
    log = FileImporter.new('spec/fixtures/invalid_import_test.json').import
    expect(log).to include('Failure: The provided file does not contain valid JSON.')
  end

  it 'should log an error when a restaurant has no name' do
    expect(@log).to include('Failure: {"brand"=>"No Name"},  ["Name can\'t be blank"]')
  end

  it 'should log an error when a menu has no name' do
    expect(@log).to include('Failure: {"meal"=>"No Name"},  ["Name can\'t be blank"]')
  end

  it 'should log an error when a menu item has no name' do
    expect(@log).to include('Failure: {"dish"=>"No Name", "price"=>0.0},  ["Name can\'t be blank"]')
  end

  it 'should log results for each record in the file' do
    expect(@log.length).to eq(13)
  end

  it 'should log an error when a menu can\'t be assigned to a valid restaurant' do
    expect(@log).to include('Failure: no valid restaurant for menu \'Menu 3\'.')
  end

  it 'should create restaurants from the import file' do
    expect(Restaurant.count).to eq(2)
  end

  it 'should create menus from the import file' do
    expect(Menu.count).to eq(3)
  end

  it 'should create menu items from the import file' do
    expect(MenuItem.count).to eq(2)
  end

  it 'should allow the same menu item to be on multiple menus with different prices' do
    menu_item = MenuItem.find_by(name: 'Menu Item 1')
    menu_items_menus = menu_item.menu_items_menus.order(:price)
    expect(menu_item.menus.count).to eq(2)
    expect(menu_items_menus.first.price).to eq(1.00)
    expect(menu_items_menus.second.price).to eq(2.00)
  end
end