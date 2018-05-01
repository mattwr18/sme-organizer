require 'rails_helper'

describe 'navigation' do
  before do
    visit root_path
  end

  it 'has a homepage' do
    expect(page.status_code).to eq(200)
  end

  it 'has a title' do
    expect(page).to have_content(/MissMoo/)
  end

  it 'has a total of all the sales' do
    sale1 = FactoryBot.create(:sale)
    sale2 = FactoryBot.create(:second_sale)

    visit root_path

    expect(page).to have_content(/Total sales: 21/)
  end

  it 'has total of all the purchases' do
    purchase1 = FactoryBot.create(:purchase)
    purchase2 = FactoryBot.create(:second_purchase)

    visit root_path

    expect(page).to have_content(/Total purchases: 35/)
  end

  it 'has the total profit' do
    sale = FactoryBot.create(:sale)
    purchase = FactoryBot.create(:purchase)

    visit root_path

    expect(page).to have_content(/Profit: -5/)
  end

  it 'has a link to the sales page' do
    click_on "Sales"

    expect(current_path).to eq(sales_path)
  end

  it 'has a link to the purchases page' do
    click_on "Purchases"

    expect(current_path).to eq(purchases_path)

  end
end
