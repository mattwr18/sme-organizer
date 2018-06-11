# frozen_string_literal: true

require 'rails_helper'

describe 'navigation' do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product) }

  before do
    login_as(user, scope: :user)
    visit root_path
  end

  it 'has a homepage' do
    expect(page.status_code).to eq(200)
  end

  it 'has a title' do
    expect(page).to have_content(/SME Organizer/)
  end

  it 'has a total of all the sales' do
    FactoryBot.create(:sale, user_id: user.id, product_ids: product.id)
    FactoryBot.create(:second_sale, user_id: user.id, product_ids: product.id)

    visit root_path

    expect(page).to have_content('Total sales: $21.00')
  end

  it 'has total of all the purchases' do
    FactoryBot.create(:purchase, user_id: user.id)
    FactoryBot.create(:second_purchase, user_id: user.id)

    visit root_path

    expect(page).to have_content('Total purchases: $35.00')
  end

  it 'has the total profit' do
    FactoryBot.create(:sale, user_id: user.id, product_ids: product.id)
    FactoryBot.create(:purchase, user_id: user.id)

    visit root_path

    expect(page).to have_content('Profit: -$5.00')
  end

  it 'has a link to the sales page' do
    click_on 'Sales'

    expect(current_path).to eq(sales_path)
  end

  it 'has a link to the purchases page' do
    click_on 'Purchases'

    expect(current_path).to eq(purchases_path)
  end
end
