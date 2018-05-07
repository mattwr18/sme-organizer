# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'creation' do
    it 'can be created' do
      @ingredient = FactoryBot.create(:ingredient)
      expect(@ingredient).to be_valid
    end
  end
end
