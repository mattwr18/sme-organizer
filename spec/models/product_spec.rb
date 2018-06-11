# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'creation' do
    before do
      @product = FactoryBot.create(:product)
    end

    it 'can be created' do
      expect(@product).to be_valid
    end

    it 'cannot be created without a name' do
      @product.name = nil
      expect(@product).to_not be_valid
    end
  end

  describe 'deletion' do
    before do
      @product = FactoryBot.create(:second_product)
    end

    it 'can be deleted' do
      @product.destroy
      assert @product.delete 
    end
  end
end
