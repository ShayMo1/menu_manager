require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it 'should require a name' do
    restaurant = Restaurant.new(name: nil)
    restaurant.valid?
    expect(restaurant.errors.count).to eq(1)
    expect(restaurant.errors.first.message).to eq('can\'t be blank')
  end
end
