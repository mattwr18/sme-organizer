require 'rails_helper'

describe 'navigation' do
  let(:user) { FactoryBot.create(:user) }

  let(:purchase) do
    Purchase.create(amount: 10, description: 'Something', user_id: user.id)
  end

  before do
    login_as(user, :scope => :user)
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

       post_from_other_user = Purchase.create(amount: 12, description: "This post shouldn't be seen", user_id: other_user.id)

       visit purchases_path

       expect(page).to_not have_content(/This post shouldn't be seen/)
     end

    it 'has total of all the purchases' do
      purchase1 = FactoryBot.create(:purchase, user_id: user.id)
      purchase2 = FactoryBot.create(:second_purchase, user_id: user.id)

      visit purchases_path

      expect(page).to have_content(/Total purchases: 35/)
    end

    it 'has a link to the homepage' do
      click_on 'Home'

      expect(current_path).to eq(root_path)
    end

    it 'has a link to the purchases page' do
      click_on 'Purchases'

      expect(current_path).to eq(purchases_path)
    end
  end

  describe 'creation' do
    before do
      visit new_purchase_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'has a link from the purchases page' do
      visit purchases_path
      click_on 'Create a new purchase'

      expect(current_path).to eq(new_purchase_path)
    end

    it 'has a way to create a purchase' do
      fill_in 'purchase[amount]', with: 10
      fill_in 'purchase[description]', with: 'Anything'

      expect { click_on "Save" }.to change(Purchase, :count).by(1)
    end

    it 'will have a user associated with it' do
      fill_in 'purchase[amount]', with: 11
      fill_in 'purchase[description]', with: 'User associated'
      click_on "Save"

      expect(User.last.purchases.last.description).to eq('User associated')
    end
  end

  describe 'edit' do
    it 'can be edited' do
      visit edit_purchase_path(purchase)

      fill_in 'purchase[amount]', with: 11
      fill_in 'purchase[description]', with: 'Edited purchase'

      click_on 'Save'

      expect(page).to have_content(/Edited purchase/)
    end
  end

  describe 'delete' do
    it 'can be deleted' do
      logout(:user)

      delete_user = FactoryBot.create(:user)
      login_as(delete_user, :scope => :user)

      purchase_to_delete = Purchase.create(amount: 15, description: 'Kinda expensive', user_id: delete_user.id)

      visit purchases_path

      click_link("delete_purchase_#{purchase_to_delete.id}_from_index")

      expect(page.status_code).to eq(200)
    end
  end
end
