# frozen_string_literal: true

require 'rails_helper'

describe 'navigation' do
  let(:user) { FactoryBot.create(:user) }
  let(:ingredient) { FactoryBot.create(:ingredient) }

  before do
    login_as(user, scope: :user)
  end

  describe 'index' do
    before do
      visit ingredients_path
    end

    it 'has a ingredients page with title' do
      expect(page.status_code).to eq(200)
      expect(page).to have_content(/Ingredients/)
    end

    it 'has a list of ingredients' do
      FactoryBot.build_stubbed(:ingredient)
      FactoryBot.build_stubbed(:second_ingredient)
      visit ingredients_path
      expect(page).to have_content(/Ingredient|second/)
    end

    it 'has a scope so that only ingredient creators can see their ingredients' do
      non_authorized_user = FactoryBot.create(:non_authorized_user)
      FactoryBot.create(:ingredient, user_id: non_authorized_user.id)
      visit ingredients_path
      expect(page).to_not have_content(/FactoryBot ingredient/)
    end
  end

  describe 'creation' do
    before do
      visit new_ingredient_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'has a way to create an ingredient' do
      fill_in 'ingredient[name]', with: 'Some ingredient'
      expect { click_on 'Create Ingredient' }.to change(Ingredient, :count).by(1)
    end

    it 'will have a user associated with it' do
      fill_in 'ingredient[name]', with: 'Some ingredient'
      click_on 'Create Ingredient'

      expect(User.last.ingredients.last.name).to eq('Some ingredient')
    end
  end

  describe 'edit' do
    it 'can be edited' do
      visit edit_ingredient_path(ingredient)
      fill_in 'ingredient[name]', with: 'Edited ingredient'
      click_on 'Update Ingredient'
      expect(page).to have_content(/Edited ingredient/)
    end
  end

  describe 'delete' do
    it 'can be deleted' do
      logout(:user)
      delete_user = FactoryBot.create(:user)
      login_as(delete_user, scope: :user)
      ingredient_to_delete = Ingredient.create(name: 'Ingredient to delete',
                                               user_id: delete_user.id)

      visit ingredients_path

      click_link("delete_ingredient_#{ingredient_to_delete.id}_from_index")
      expect(page.status_code).to eq(200)
    end
  end
end
