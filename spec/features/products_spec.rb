# frozen_string_literal: true

require 'rails_helper'

describe 'navigation' do
  let(:user) { FactoryBot.create(:user) }
  let(:ingredient) { FactoryBot.create(:ingredient) }

  let(:product) do
    Product.create(name: 'product1', user_id: user.id)
  end

  before do
    login_as(user, scope: :user)
  end

  describe 'index' do
    before do
      visit products_path
    end

    it 'has a products page' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Products' do
      expect(page).to have_content(/Products/)
    end

    it 'has a list of products' do
      product1 = FactoryBot.build_stubbed(:product)
      product2 = FactoryBot.build_stubbed(:second_product)

      visit products_path

      expect(page).to have_content(/Product|second/)
    end

    it 'has a scope so that only products creators can see their products' do
      other_user = User.create(email: 'nonauth@example.com', password: 'asdfasdf', password_confirmation: 'asdfasdf')

      product_from_other_user = Product.create(name: "This product shouldn't be seen", user_id: other_user.id)

      visit products_path

      expect(page).to_not have_content(/This product shouldn't be seen/)
    end
  end

  describe 'creation' do
    let(:ingredient) { FactoryBot.create(:ingredient) }

    before do
      visit new_product_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'has a link from the products page' do
      visit products_path
      click_on 'Create a new product'

      expect(current_path).to eq(new_product_path)
    end

    it 'has nested forms for Ingredients' do
      expect(page).to have_field(:product_ingredients_attributes_0_name)
      expect(page).to have_field(:product_ingredients_attributes_0_amount)
      expect(page).to have_field(:product_ingredients_attributes_0_amount_type)
    end

    it 'allows product creation with ingredients' do
      FactoryBot.create(:ingredient)
      visit new_product_path
      fill_in :product_name, with: 'Product name'
      select 'FactoryBot ingredient', from: 'product_ingredients_attributes_0_name'
      fill_in :product_ingredients_attributes_0_amount, with: 150
      select 'gram(s)', from: :product_ingredients_attributes_0_amount_type

      expect { click_on 'Create Product' }.to change(Product, :count).by(1)
    end

    it 'allows product creation without ingredients' do
      fill_in 'product[name]', with: 10
      expect { click_on 'Create Product' }.to change(Product, :count).by(1)
    end

    context 'more than one indgredient to add', js: true do
      it 'has a way to add more ingredient forms' do
        click_on 'Add ingredient'

        expect(page).to have_css('input', count: 5)
      end

      it 'allows selection of previously used ingredients' do
        ingredient1 = FactoryBot.create(:ingredient)
        visit new_product_path
      end
    end

    it 'will have a user associated with it' do
      client = FactoryBot.create(:client, user_id: user.id)

      visit new_product_path

      fill_in 'product[name]', with: 'User associated'
      click_on 'Create Product'

      expect(User.last.products.last.name).to eq('User associated')
    end
  end

  describe 'edit' do
    before do
      visit edit_product_path(product)
    end

    it 'can be edited' do
      fill_in 'product[name]', with: 'Edited product'
      click_on 'Update Product'
      expect(page).to have_content(/Edited product/)
    end

    context 'editing ingredients', js: true do
      it 'allows an ingredient to be added later' do
        FactoryBot.create(:ingredient)
        visit edit_product_path(product)
        click_on 'Add ingredient'

        within ('.nested-fields') do
          select 'FactoryBot ingredient', from: 'Ingredient'
        end

        click_on 'Update Product'
        expect(page).to have_content(/FactoryBot ingredient/)
      end

      it 'allows editing of ingredients' do
        product_with_ingredient = FactoryBot.create(:product_with_ingredient)

        visit edit_product_path(product_with_ingredient)
        select 'FactoryBot ingredient', from: 'Ingredient'
        fill_in 'product_ingredients_attributes_0_amount', with: 100

        click_on 'Update Product'
        expect(page).to have_content(/100/)
      end
    end
  end

  describe 'delete' do
    before do
      logout(:user)

      @delete_user = FactoryBot.create(:user)
      login_as(@delete_user, scope: :user)
    end

    it 'can be deleted' do
      product_to_delete = Product.create(name: 'product2', user_id: @delete_user.id)
      visit products_path

      click_link("delete_product_#{product_to_delete.id}_from_index")

      expect(page.status_code).to eq(200)
    end
  end
end
