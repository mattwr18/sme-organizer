# frozen_string_literal: true

require 'rails_helper'

describe 'navigation' do
  let(:user) { FactoryBot.create(:user) }

  let(:purchase) do
    Purchase.create(amount: 10, description: 'Something', vendor: 'Someone', user_id: user.id)
  end

  before do
    login_as(user, scope: :user)
  end

  describe 'index' do
    before do
      visit purchases_path
    end

    it 'has a purchases page' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Purchases' do
      expect(page).to have_content(/Purchases/)
    end

    it 'has a list of purchases' do
      purchase1 = FactoryBot.build_stubbed(:purchase)
      purchase2 = FactoryBot.build_stubbed(:second_purchase)

      visit purchases_path

      expect(page).to have_content(/Purchase|second/)
    end

    it 'has a scope so that only purchases creators can see their purchases' do
      other_user = User.create(email: 'nonauth@example.com', password: 'asdfasdf', password_confirmation: 'asdfasdf')

      purchase_from_other_user = Purchase.create(amount: 12, description: "This post shouldn't be seen", vendor: 'New', user_id: other_user.id)

      visit purchases_path

      expect(page).to_not have_content(/This post shouldn't be seen/)
    end

    it 'has total of all the purchases' do
      purchase1 = FactoryBot.create(:purchase, user_id: user.id)
      purchase2 = FactoryBot.create(:second_purchase, user_id: user.id)

      visit purchases_path

      expect(page).to have_content("Total purchases: $35.00")
    end
  end

  describe 'creation' do
    before do
      vendor = FactoryBot.create(:vendor, user_id: user.id)
      visit new_purchase_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'has a way to create a purchase' do
      select 'FactoryBot vendor', from: :purchase_vendor, visible: false
      fill_in 'purchase[amount]', with: 10
      fill_in 'purchase[description]', with: 'Anything'

      expect { click_on 'Create Purchase' }.to change(Purchase, :count).by(1)
    end

    it 'will have a user associated with it' do
      select 'FactoryBot vendor', from: :purchase_vendor, visible: false
      fill_in 'purchase[amount]', with: 11
      fill_in 'purchase[description]', with: 'User associated'
      click_on 'Create Purchase'

      expect(User.last.purchases.last.description).to eq('User associated')
    end
  end

  describe 'edit' do
    it 'can be edited' do
      visit edit_purchase_path(purchase)

      fill_in 'purchase[amount]', with: 11
      fill_in 'purchase[description]', with: 'Edited purchase'

      click_on 'Update Purchase'

      expect(page).to have_content(/Edited purchase/)
    end
  end

  describe 'delete' do
    it 'can be deleted' do
      logout(:user)

      delete_user = FactoryBot.create(:user)
      login_as(delete_user, scope: :user)

      purchase_to_delete = Purchase.create(amount: 15, description: 'Kinda expensive', vendor: 'Some vendor', user_id: delete_user.id)

      visit purchases_path

      click_link("delete_purchase_#{purchase_to_delete.id}_from_index")

      expect(page.status_code).to eq(200)
    end
  end
end
