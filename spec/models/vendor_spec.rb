# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vendor, type: :model do
  describe 'creation' do
    before do
      @vendor = FactoryBot.create(:vendor)
    end

    it 'can be created' do
      expect(@vendor).to be_valid
    end

    it 'cannot be created without a name' do
      @vendor.name = nil
      expect(@vendor).to_not be_valid
    end
  end
end
