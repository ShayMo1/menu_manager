require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  before(:all) do
    @menu_item = MenuItem.new(name: nil, price: nil, menu: nil)
    @menu_item.valid?
  end

  it 'should require a name' do
    expect(@menu_item.errors.messages).to include(name: ['can\'t be blank'])
  end

  it 'should require a numeric price' do
    expect(@menu_item.errors.messages).to include(price: ['is not a number'])
  end

  it 'should not allow a negative price' do
    @menu_item.price = -1.0
    @menu_item.valid?
    expect(@menu_item.errors.messages).to include(price: ['must be greater than or equal to 0.0'])
  end

  it 'should require an extant menu' do
    expect(@menu_item.errors.messages).to include(menu: ['must exist', 'can\'t be blank'])
  end
end
