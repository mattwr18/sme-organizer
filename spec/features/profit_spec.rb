require 'rails_helper'

describe 'navigation' do
  it 'has a profits page' do
    visit profit_path

    expect(page.status_code).to eq(200)
  end
end
