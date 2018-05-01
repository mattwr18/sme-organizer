require 'rails_helper'

describe 'navigation' do
  before do
    visit root_path
  end

  it 'has a homepage' do
    expect(page.status_code).to eq(200)
  end

  it 'has a title of Homepage' do
    expect(page).to have_content(/Homepage/)
  end

  it 'has total of all the purchases' do
    purchase1 = FactoryBot.create(:purchase)
    purchase2 = FactoryBot.create(:second_purchase)

    visit root_path

    expect(page).to have_content(/Total purchases: 35/)
  end
end
