# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sale, type: :model do
  describe 'creation' do
    before do
      product = FactoryBot.create(:product)
      @sale = FactoryBot.create(:sale, product_ids: product.id)
    end

    it 'can be created' do
      expect(@sale).to be_valid
    end

    it 'cannot be created without a product' do
      @sale.product_ids = nil
      expect(@sale).to_not be_valid
    end

    it 'cannot be created without an amount' do
      @sale.amount = nil
      expect(@sale).to_not be_valid
    end

    it 'has an amount greater than 0.0' do
      @sale.amount = 0.0
      expect(@sale).to_not be_valid
    end
  end

  describe 'deletion' do
    before do
      product = FactoryBot.create(:product)
      @sale = FactoryBot.create(:sale, product_ids: product.id)
    end

    it 'can be deleted' do
      @sale.destroy
      expect(@sale).to_not be_valid
    end
  end
end
