class ProductsIngredientsController < ApplicationController
  def show;  end

  def destroy
    @products_ingredient = ProductsIngredient.find(params[:id])
    @ingredient = @products_ingredient.ingredient
    @products_ingredient.destroy

    puts "ingredient: #{@ingredient}"

    respond_to do |format|
      format.html {redirect_to product_path(@product), notice: 'Ingredient was succesfully deleted from product' }
    end
  end
end
