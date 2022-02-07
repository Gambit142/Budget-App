require 'rails_helpers'

describe Record, type: :model do
  before(:each) do
    @user = User.create!(name: 'Leroy', email: 'leroy@gmail.com', password: '123456')
    @record = @user.categories.create!(name: 'Games', icon: 'PlayStation 5')
  end
end