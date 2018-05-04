require 'rails_helper'

describe 'navigation' do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user, :scope => :user)
    visit root_path
  end

  describe 'nav tabs' do
    it 'has a link to homepage' do
      click_on 'Home'

      expect(current_path).to eq(root_path)
    end

    it 'has a link to sales page' do
      click_on 'Sales'

      expect(current_path).to eq(sales_path)
    end

    it 'has a link to purchases page' do
      click_on 'Purchases'

      expect(current_path).to eq(purchases_path)
    end


    it 'has a link to clients page' do
      click_on 'Clients'

      expect(current_path).to eq(clients_path)
    end

    it 'has a link to products page' do
      click_on 'Products'

      expect(current_path).to eq(products_path)
    end
  end
end
