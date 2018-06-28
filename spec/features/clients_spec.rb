# frozen_string_literal: true

require 'rails_helper'

describe 'navigation' do
  let(:user) { FactoryBot.create(:user) }

  let(:client) do
    Client.create(name: 'Paula', address: 'some address', user_id: user.id)
  end

  before do
    login_as(user, scope: :user)
  end

  describe 'index' do
    before do
      visit clients_path
    end

    it 'has a clients page' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title' do
      expect(page).to have_content(/Clients/)
    end

    it 'has a list of clients' do
      client1 = FactoryBot.build_stubbed(:client)
      client2 = FactoryBot.build_stubbed(:second_client)

      visit clients_path

      expect(page).to have_content(/Client|second/)
    end

    it 'has a scope so that only clients creators can see their clients' do
      other_user = User.create(email: 'nonauth@example.com', password: 'asdfasdf', password_confirmation: 'asdfasdf')

      post_from_other_user = Client.create(name: 'Daenaryes', address: 'some fake address', user_id: other_user.id)

      visit clients_path

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
      visit new_client_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'has a link from the clients page' do
      visit clients_path
      click_on 'Create a new client'

      expect(current_path).to eq(new_client_path)
    end

    it 'has a way to create a client' do
      fill_in 'client[name]', with: 'Goldman'
      fill_in 'client[address]', with: 'Anything'
      fill_in 'client[obs]', with: 'Something'

      expect { click_on 'Create Client' }.to change(Client, :count).by(1)
    end

    it 'will have a user associated with it' do
      fill_in 'client[name]', with: 'Associated'
      fill_in 'client[address]', with: 'User associated'
      click_on 'Create Client'

      expect(User.last.clients.last.address).to eq('User associated')
    end
  end

  describe 'edit' do
    it 'can be edited' do
      visit edit_client_path(client)

      fill_in 'client[name]', with: 11
      fill_in 'client[address]', with: 'Edited address'
      fill_in 'client[obs]', with: 'Edited obs'

      click_on 'Update Client'

      expect(page).to have_content(/Edited address|Edited obs/)
    end
  end

  describe 'delete' do
    it 'can be deleted' do
      logout(:user)

      delete_user = FactoryBot.create(:user)
      login_as(delete_user, scope: :user)

      client_to_delete = Client.create(name: 'Matt', address: 'delete address', obs: 'something important', user_id: delete_user.id)

      visit clients_path

      click_link("delete_client_#{client_to_delete.id}_from_index")

      expect(page.status_code).to eq(200)
    end
  end
end
