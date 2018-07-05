class AddColumnUserIdToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_reference :ingredients, :user, foreign_key: true
  end
end
