# frozen_string_literal: true

require 'rails_helper'

describe 'navigation' do
  let(:user) { FactoryBot.create(:user) }

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

    context 'more than one indgredient to add', js: true do
      it 'has a way to add more ingredient forms' do
        click_on 'Add ingredient'

        within ('.nested-fields:nth-child(2)') do
          expect(page).to have_content('Ingredient')
        end
      end

      it 'can be created with more than one ingredient' do
        fill_in :product_name, with: 'Product name'
        fill_in :product_ingredients_attributes_0_name, with: 'Ingredient name'
        fill_in :product_ingredients_attributes_0_amount, with: 150
        select 'gram(s)', from: :product_ingredients_attributes_0_amount_type
        click_on 'Add ingredient'

        within ('.nested-fields:nth-child(2)') do
          find('.ingredient_name_field').set('Ingredient2')
          find('.ingredient_amount_field').set(160)
          find('.ingredient_amount_type_field').set('gram(s)')
        end

        click_on 'Add ingredient'

        within ('.nested-fields:nth-child(3)') do
          find('.ingredient_name_field').set('Ingredient3')
          find('.ingredient_amount_field').set(1600)
          find('.ingredient_amount_type_field').set('gram(s)')
        end

        expect { click_on 'Save' }.to change(Product, :count).by(1)
      end
    end

    it 'allows product creation with ingredients' do
      fill_in :product_name, with: 'Product name'
      fill_in :product_ingredients_attributes_0_name, with: 'Ingredient name'
      fill_in :product_ingredients_attributes_0_amount, with: 150
      select 'gram(s)', from: :product_ingredients_attributes_0_amount_type

      expect { click_on 'Save' }.to change(Product, :count).by(1)
    end

    it 'allows ingredient creation with prodcuts' do
      fill_in 'Name', with: 'Product'
      fill_in :product_ingredients_attributes_0_name, with: 'Ingredient1'
      fill_in :product_ingredients_attributes_0_amount, with: 150
      select 'gram(s)', from: :product_ingredients_attributes_0_amount_type

      expect { click_on 'Save' }.to change(Ingredient, :count).by(1)
    end

    it 'allows product creation without ingredients' do
      fill_in 'product[name]', with: 10

      expect { click_on 'Save' }.to change(Product, :count).by(1)
    end

    it 'will have a user associated with it' do
      client = FactoryBot.create(:client, user_id: user.id)

      visit new_product_path

      fill_in 'product[name]', with: 'User associated'
      click_on 'Save'

      expect(User.last.products.last.name).to eq('User associated')
    end
  end

  describe 'edit' do
    it 'can be edited' do
      visit edit_product_path(product)

      fill_in 'product[name]', with: 'Edited product'

      click_on 'Save'

      expect(page).to have_content(/Edited product/)
    end
  end

  describe 'delete' do
    it 'can be deleted' do
      logout(:user)

      delete_user = FactoryBot.create(:user)
      login_as(delete_user, scope: :user)

      product_to_delete = Product.create(name: 'product2', user_id: delete_user.id)

      visit products_path

      click_link("delete_product_#{product_to_delete.id}_from_index")

      expect(page.status_code).to eq(200)
    end
  end
end
