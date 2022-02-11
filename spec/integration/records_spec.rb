require 'rails_helper'

RSpec.describe 'Records Index Page Features', type: :feature do
  before(:each) do
    visit user_session_path
    @vladmir = User.create!(
      name: 'Vladmir', email: 'vladmir@test.com', password: 'vladmir123'
    )
    fill_in 'Email', with: 'vladmir@test.com'
    fill_in 'Password', with: 'vladmir123'
    click_button 'Log in'

    @games = @vladmir.categories.new(name: 'games')
    @games.icon.attach(
      io: File.open(Rails.root.join('spec', 'fixtures', 'multi-colored.png')),
      filename: 'multi-colored.png',
      content_type: 'application/png'
    )
    @games.save!
    @x_box = @vladmir.records.create!(name: 'X-Box', amount: 105.5)
    @x_box.categories_records.create!(category_id: @games.id)
    visit category_records_path(@games)
  end

  describe 'Index Page Contents' do
    it 'can see the contents of the page' do
      expect(page).to have_content 'Total Payment:'
    end

    it 'should see total amount of transactions' do
      expect(page).to have_content '$105.5'
    end

    it 'should have the correct transaction ID' do
      expect(page).to have_content "Transaction No #{@x_box.id}"
    end

    it 'should have a button for creating new records' do
      expect(page).to have_button('Add New Transaction')
    end

    it 'should direct me to a page for creating new record' do
      click_button('Add New Transaction')
      expect(page).to have_current_path(new_category_record_url(@games))
      expect(page).to have_content 'Create Your Transaction'
    end

    it 'completes the creation of a new record' do
      click_button('Add New Transaction')
      fill_in 'Name', with: 'PlayStation 5'
      fill_in 'Amount', with: 110.6
      find(:css, "#add_record_category_ids_#{@games.id}").set(true)
      click_button('Create Transaction')
      expect(page).to have_current_path(category_records_path(@games))
      expect(page).to have_content 'PlayStation 5'
      expect(page).to have_content '$216.1'
    end
  end
end
