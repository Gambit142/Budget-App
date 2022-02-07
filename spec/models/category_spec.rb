require 'rails_helper'

describe Category, type: :model do
  before(:each) do
    @user = User.create!(name: 'Leroy', email: 'leroy@gmail.com', password: '123456')
    @category = @user.categories.create!(name: 'Games', icon: 'PlayStation 5')
  end

  it 'Category should be valid' do
    expect(@category).to be_valid
  end

  it 'Category should not be valid without a name' do
    @category.name = nil
    expect(@category).to_not be_valid
    @category.name = ''
    expect(@category).to_not be_valid
  end

  it 'Category should not be valid if name is too long' do
    @category.name = 'g' * 101
    expect(@category).to_not be_valid
  end

  it 'Category should not be valid without an icon' do
    @category.icon = nil
    expect(@category).to_not be_valid
    @category.icon = ''
    expect(@category).to_not be_valid
  end

  it 'Category should not be valid if icon is too long' do
    @category.icon = 'g' * 251
    expect(@category).to_not be_valid
  end
end