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


    it 'cannot be created without a total' do
      @purchase.total = nil
      expect(@purchase).to_not be_valid
    end

    it 'has an total greater than 0.0' do
      @purchase.total = 0.0
      expect(@purchase).to_not be_valid
    end
  end
end
