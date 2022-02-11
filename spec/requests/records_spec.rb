require 'rails_helper'

RSpec.describe Record, type: :request do
  before :each do
    user = User.create!(name: 'Al', email: 'al@example.com', password: 'password')
    @category = user.categories.new(name: 'Games')
    @category.icon.attach(
      io: File.open(Rails.root.join('spec', 'fixtures', 'multi-colored.png')), 
      filename: 'multi-colored.png',
      content_type: 'application/xlsx'
    )
    @category.save!
    login_as user
  end

  describe 'GET #index page' do
    it 'tests the URL path for records#index' do
      get category_records_url(@category)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include('Total Payment')
    end
  end

  describe 'GET #new page' do
    it 'tests the URL path for records#new' do
      get new_category_record_url(@category)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
      expect(response.body).to include('Create Your Transaction')
    end
  end
end