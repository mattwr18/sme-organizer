require 'rails_helper'

describe 'navigation' do
  it 'has a purchases page' do
    visit purchases_path

    expect(page.status_code).to eq(200)
  end
end
