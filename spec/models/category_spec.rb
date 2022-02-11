require 'rails_helper'

describe Category, type: :model do
  before(:each) do
    @user = User.create!(name: 'Leroy', email: 'leroy@gmail.com', password: '123456')
    @category = @user.categories.new(name: 'Games')
    @category.icon.attach(
      io: File.open(Rails.root.join('spec', 'fixtures', 'multi-colored.png')),
      filename: 'multi-colored.png',
      content_type: 'application/xlsx'
    )
    @category.save!
  end

  it 'should be valid' do
    expect(@category).to be_valid
  end

  it 'should not be valid without a name' do
    @category.name = nil
    expect(@category).to_not be_valid
    @category.name = ''
    expect(@category).to_not be_valid
  end

  it 'should not be valid if name is too long' do
    @category.name = 'g' * 101
    expect(@category).to_not be_valid
  end

  it 'should have a file attached' do
    expect(@category.icon).to be_attached
  end
end
