require 'rails_helper'

describe 'navigation' do
  it 'has a homepage' do
    visit root_path

    expect(page.status_code).to eq(200)
  end
end
