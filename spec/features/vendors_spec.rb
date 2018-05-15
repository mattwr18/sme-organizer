require 'rails_helper'

describe 'navigation' do
  let(:user) { FactoryBot.create(:user) }

  let(:vendor) do
    Vendor.create(name: 'Paula', phone_number: 'some phone number', user_id: user.id)
  end

  before do
    login_as(user, scope: :user)
  end

  describe 'index' do
    before do
      visit vendors_path
    end

    it 'has a vendors page' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title' do
      expect(page).to have_content(/Vendors/)
    end

    it 'has a list of vendors' do
      vendor1 = FactoryBot.build_stubbed(:vendor)
      vendor2 = FactoryBot.build_stubbed(:second_vendor)

      visit vendors_path

      expect(page).to have_content(/Vendor|second/)
    end

    it 'has a scope so that only vendors creators can see their vendors' do
      other_user = User.create(email: 'nonauth@example.com', password: 'asdfasdf', password_confirmation: 'asdfasdf')

      post_from_other_user = Vendor.create(name: 'Daenaryes', phone_number: 'some fake phone number', user_id: other_user.id)

      visit vendors_path

      expect(page).to_not have_content(/This post shouldn't be seen/)
    end

    it 'has a link to homepage' do
      click_on 'Home'

      expect(current_path).to eq(root_path)
    end

    it 'has a link to purchases page' do
      click_on 'Purchases'

      expect(current_path).to eq(purchases_path)
    end
  end

  describe 'creation' do
    before do
      visit new_vendor_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'has a link from the vendors page' do
      visit vendors_path
      click_on 'Create a new vendor'

      expect(current_path).to eq(new_vendor_path)
    end

    it 'has a way to create a vendor' do
      fill_in 'vendor[name]', with: 'Goldman'
      fill_in 'vendor[phone_number]', with: 'Anything'
      fill_in 'vendor[obs]', with: 'Something'

      expect { click_on 'Save' }.to change(Vendor, :count).by(1)
    end

    it 'will have a user associated with it' do
      fill_in 'vendor[name]', with: 'Associated'
      fill_in 'vendor[phone_number]', with: 'User associated'
      click_on 'Save'

      expect(User.last.vendors.last.phone_number).to eq('User associated')
    end
  end

  describe 'edit' do
    it 'can be edited' do
      visit edit_vendor_path(vendor)

      fill_in 'vendor[name]', with: 11
      fill_in 'vendor[phone_number]', with: 'Edited phone number'
      fill_in 'vendor[obs]', with: 'Edited obs'

      click_on 'Save'

      expect(page).to have_content(/Edited phone number|Edited obs/)
    end
  end

  describe 'delete' do
    it 'can be deleted' do
      logout(:user)

      delete_user = FactoryBot.create(:user)
      login_as(delete_user, scope: :user)

      vendor_to_delete = Vendor.create(name: 'Matt', phone_number: 'delete phone number', obs: 'something important', user_id: delete_user.id)

      visit vendors_path

      click_link("delete_vendor_#{vendor_to_delete.id}_from_index")

      expect(page.status_code).to eq(200)
    end
  end
end
