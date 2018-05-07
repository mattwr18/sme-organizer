# frozen_string_literal: true

class CreateIngredientsAndProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :amount
      t.string :amount_type

      t.timestamps
    end

    create_table :products do |t|
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
    end

    create_table :ingredients_products, id: false do |t|
      t.belongs_to :ingredient, index: true
      t.belongs_to :product, index: true
    end
  end
end
