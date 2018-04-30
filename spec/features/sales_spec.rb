require 'rails_helper'

describe 'navigation' do
  it 'has a sales page' do
    visit sales_path

    expect(page.status_code).to eq(200)
  end
end
