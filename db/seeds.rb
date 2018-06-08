# frozen_string_literal: true

@user = User.create!(email: 'test@test.com',
                     password: 'asdfasdf',
                     password_confirmation: 'asdfasdf')

Product.create!(name: 'product1', user_id: @user.id, ingredients_attributes: [{ name: 'ingredient1', amount: 6, amount_type: 'grams' }])
Product.create!(name: 'product2', user_id: @user.id, ingredients_attributes: [{ name: 'ingredient2', amount: 60, amount_type: 'grams' }])
Product.create!(name: 'product3', user_id: @user.id, ingredients_attributes: [{ name: 'ingredient3', amount: 16, amount_type: 'grams' }])
Product.create!(name: 'product4', user_id: @user.id, ingredients_attributes: [{ name: 'ingredient4', amount: 65, amount_type: 'grams' }])
Product.create!(name: 'product5', user_id: @user.id, ingredients_attributes: [{ name: 'ingredient5', amount: 56, amount_type: 'grams' }])
