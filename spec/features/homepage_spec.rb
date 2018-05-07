# frozen_string_literal: true

require 'rails_helper'

describe 'navigation' do
  let(:user) { FactoryBot.create(:user) }

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
    sale1 = FactoryBot.create(:sale, user_id: user.id)
    sale2 = FactoryBot.create(:second_sale, user_id: user.id)

    visit root_path

    expect(page).to have_content(/Total sales: 21/)
  end

  it 'has total of all the purchases' do
    purchase1 = FactoryBot.create(:purchase, user_id: user.id)
    purchase2 = FactoryBot.create(:second_purchase, user_id: user.id)

    visit root_path

    expect(page).to have_content(/Total purchases: 35/)
  end

  it 'has the total profit' do
    sale = FactoryBot.create(:sale, user_id: user.id)
    purchase = FactoryBot.create(:purchase, user_id: user.id)

    visit root_path

    expect(page).to have_content(/Profit: -5/)
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
