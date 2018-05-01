require 'rails_helper'

RSpec.describe Sale, type: :model do
  describe 'creation' do
    before do
      @purchase = FactoryBot.create(:purchase)
    end

    it 'can be created' do
      expect(@purchase).to be_valid
    end

    it 'cannot be created without an amount' do
      @purchase.amount = nil
      expect(@purchase).to_not be_valid
    end

    it 'has an amount greater than 0.0' do
     @purchase.amount = 0.0
     expect(@purchase).to_not be_valid
  end

    it 'cannot be created without a description' do
      @purchase.description = nil
      expect(@purchase).to_not be_valid
    end
  end
end
