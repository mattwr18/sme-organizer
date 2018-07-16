# frozen_string_literal: true

require 'rails_helper'

describe 'navigation' do
  let(:user) { FactoryBot.create(:user) }
  let(:purchase) { FactoryBot.create(:purchase) }

  before do
    login_as(user, scope: :user)
  end

  describe 'index' do
    before do
      visit purchases_path
    end

    it 'has a purchases page with title' do
      expect(page.status_code).to eq(200)
      expect(page).to have_content(/Purchases/)
    end

    it 'has a list of purchases' do
      FactoryBot.build_stubbed(:purchase)
      FactoryBot.build_stubbed(:second_purchase)
      visit purchases_path
      expect(page).to have_content(/Purchase|second/)
    end

    it 'has a scope so that only purchase creators can see their purchases' do
      non_authorized_user = FactoryBot.create(:non_authorized_user)
      FactoryBot.create(:purchase, user_id: non_authorized_user.id)
      visit purchases_path
      expect(page).to_not have_content(/FactoryBot purchase/)
    end

    it 'has total of all the purchases' do
      FactoryBot.create(:purchase, user_id: user.id)
      FactoryBot.create(:second_purchase, user_id: user.id)
      visit purchases_path
      expect(page).to have_content('Total purchases: $35.00')
    end
  end

  describe 'creation' do
    before do
      FactoryBot.create(:vendor, user_id: user.id)
      visit new_purchase_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
      expect(page).to have_css('input', count: 3)
      expect(page).to have_css('select', count: 3)
    end

    it 'has a way to create a purchase' do
      select 'FactoryBot vendor', from: :purchase_vendor, visible: false
      fill_in 'purchase[total]', with: 10
      fill_in 'purchase[description]', with: 'Anything'

      expect { click_on 'Create Purchase' }.to change(Purchase, :count).by(1)
    end

    it 'will have a user associated with it' do
      select 'FactoryBot vendor', from: :purchase_vendor, visible: false
      fill_in 'purchase[total]', with: 11
      fill_in 'purchase[description]', with: 'User associated'
      click_on 'Create Purchase'

      expect(User.last.purchases.last.description).to eq('User associated')
    end

    it 'has nested forms for Ingredients' do
      expect(page).to have_field(:purchase_ingredients_attributes_0_name)
      expect(page).to have_field(:purchase_ingredients_attributes_0_amount)
      expect(page).to have_field(:purchase_ingredients_attributes_0_amount_type)
    end

    it 'allows purchase creation with ingredients' do
      FactoryBot.create(:ingredient)
      visit new_purchase_path
      select 'FactoryBot ingredient', from: 'purchase_ingredients_attributes_0_name'
      fill_in :purchase_ingredients_attributes_0_amount, with: 150
      select 'gram(s)', from: :purchase_ingredients_attributes_0_amount_type
      fill_in :purchase_total, with: 15
      expect { click_on 'Create Purchase' }.to change(Purchase, :count).by(1)
    end
  end

  describe 'edit' do
    it 'can be edited' do
      visit edit_purchase_path(purchase)

      fill_in 'purchase[total]', with: 11
      fill_in 'purchase[description]', with: 'Edited purchase'

      click_on 'Update Purchase'

      expect(page).to have_content(/Edited purchase/)
    end

    context 'editing ingredients', js: true do
      it 'allows an ingredient to be added later' do
        FactoryBot.create(:ingredient)
        visit edit_purchase_path(purchase)
        click_on 'Add ingredient'

        within ('.nested-fields') do
          select 'FactoryBot ingredient', from: 'Ingredient'
        end

        click_on 'Update Purchase'
        expect(page).to have_content(/FactoryBot ingredient/)
      end

      it 'allows editing of ingredients' do
        purchase_with_ingredient = FactoryBot.create(:purchase_with_ingredient)

        visit edit_purchase_path(purchase_with_ingredient)
        select 'FactoryBot ingredient', from: 'Ingredient'
        fill_in 'purchase_ingredients_attributes_0_amount', with: 100

        click_on 'Update Purchase'
        expect(page).to have_content(/100/)
      end
    end
  end

  describe 'delete' do
    it 'can be deleted' do
      logout(:user)

      delete_user = FactoryBot.create(:user)
      login_as(delete_user, scope: :user)

      purchase_to_delete = Purchase.create(total: 15,
                                           description: 'Kinda expensive',
                                           vendor: 'Some vendor',
                                           user_id: delete_user.id)

      visit purchases_path

      click_link("delete_purchase_#{purchase_to_delete.id}_from_index")

      expect(page.status_code).to eq(200)
    end
  end
end
