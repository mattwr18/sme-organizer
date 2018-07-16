class CreateJoinTableIngredientsPurchases < ActiveRecord::Migration[5.2]
  def change
    create_join_table :ingredients, :purchases do |t|
      t.index %i[ingredient_id purchase_id]
      t.index %i[purchase_id ingredient_id]
    end
  end
end
