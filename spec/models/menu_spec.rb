require 'rails_helper'

RSpec.describe Menu, type: :model do
  it 'should require a title' do
    menu = Menu.new(title: nil)
    menu.valid?
    expect(menu.errors.count).to eq(1)
    expect(menu.errors.first.message).to eq('can\'t be blank')
  end
end
