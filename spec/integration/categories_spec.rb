require 'rails_helper'

RSpec.describe 'Categories Index Page Features', type: :feature do
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
    visit categories_path
  end

  describe 'Index Page Contents' do
    it 'can see the contents of the page' do
      expect(page).to have_content 'games'
    end

    it 'should see total amount of transactions' do
      expect(page).to have_content '0'
    end

    it 'should see a button to add new category when clicked' do
      expect(page).to have_button('Add New Category')
    end

    it 'When I click the button to add a catgory, it redirects me to a page for adding new category' do
      click_button('Add New Category')
      expect(page).to have_current_path(new_category_url)
      expect(page).to have_content 'Register Your Category'
    end

    it 'completes the creation of a new category' do
      click_button('Add New Category')
      fill_in "Name", with: 'Sports'
      find(:css, '#add_category_icon').set(File.join(Rails.root + 'spec', 'fixtures', 'multi-colored.png'))
      click_button('Register Category')
      expect(page).to have_current_path(categories_url)
      expect(page).to have_content 'sports'
    end
  end
end