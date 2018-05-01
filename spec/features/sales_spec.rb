require 'rails_helper'

describe 'navigation' do

  let(:sale) do
    Sale.create(amount: 10, description: 'Something')
  end

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

    it 'has a list of sales' do
      sale1 = FactoryBot.build_stubbed(:sale)
      sale2 = FactoryBot.build_stubbed(:second_sale)

      visit sales_path

      expect(page).to have_content(/Sale|second/)
    end

    it 'has total of all the sales' do
      sale1 = FactoryBot.create(:sale)
      sale2 = FactoryBot.create(:second_sale)

      visit sales_path

      expect(page).to have_content(/Total sales: 21/)
    end
  end

  describe 'creation' do
    before do
      visit new_sale_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'has a link from the sales page' do
      visit sales_path
      click_on 'Create a new sale'

      expect(current_path).to eq(new_sale_path)
    end

    it 'has a way to create a sale' do
      fill_in 'sale[amount]', with: 10
      fill_in 'sale[description]', with: 'Anything'

      expect { click_on "Save" }.to change(Sale, :count).by(1)
    end
  end

  describe 'edit' do
    it 'can be edited' do
      visit edit_sale_path(sale)

      fill_in 'sale[amount]', with: 11
      fill_in 'sale[description]', with: 'Edited sale'

      click_on 'Save'

      expect(page).to have_content(/Edited sale/)
    end
  end

  describe 'delete' do
    it 'can be deleted' do
      sale = Sale.create(amount: 15, description: 'Kinda expensive')

      visit sales_path

      click_link("delete_sale_#{sale.id}_from_index")

      expect(page.status_code).to eq(200)
    end
  end
end
