# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe 'creation' do
    before do
      @purchase = FactoryBot.create(:purchase)
    end

    it 'can be created' do
      expect(@purchase).to be_valid
    end

    it 'cannot be created without a vendor' do
      @purchase.vendor = nil
      expect(@purchase).to_not be_valid
    end

    it 'cannot be created without an total' do
      @purchase.total = nil
      expect(@purchase).to_not be_valid
    end

    it 'has an total greater than 0.0' do
      @purchase.total = 0.0
      expect(@purchase).to_not be_valid
    end

    it 'cannot be created without a description' do
      @purchase.description = nil
      expect(@purchase).to_not be_valid
    end
  end
end
