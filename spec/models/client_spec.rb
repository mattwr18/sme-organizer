# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'creation' do
    before do
      @client = FactoryBot.create(:client)
    end

    it 'can be created' do
      expect(@client).to be_valid
    end

    it 'cannot be created without a name' do
      @client.name = nil
      expect(@client).to_not be_valid
    end

    it 'cannot be created without a address' do
      @client.address = nil
      expect(@client).to_not be_valid
    end
  end
end
