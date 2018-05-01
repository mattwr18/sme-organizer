require 'rails_helper'

describe 'navigation' do
  describe 'index' do
    before do
      visit sales_path
    end

    it 'has a sales page' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Sales' do
      expect(page).to have_content(/Sales/)
    end
  end

  describe 'creation' do
    before do
      visit new_sales_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'has a way to create a sale' do
      fill_in 'sale[amount]', with: 10
      fill_in 'sale[description]', with: 'Anything'

      expect { click_on "Save" }.to change(Sale, :count).by(1)
    end
  end
end
