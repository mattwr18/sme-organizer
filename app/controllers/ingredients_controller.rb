# frozen_string_literal: true

# Control ingredients flow
class IngredientsController < ApplicationController
  before_action :set_ingredient, only: %i[edit update show destroy]

  def index
    @ingredients = Ingredient.ingredients_by(current_user)

    respond_to do |format|
      format.html
      format.json { render json: @ingredients }
    end
  end

  def show; end

  def new
    @ingredient = Ingredient.new
  end

  def edit; end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.user_id = current_user.id

    if @ingredient.save
      redirect_to @ingredient, notice: 'Ingredient was successfully created'
    else
      render :new
    end
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to @ingredient, notice: 'Ingredient was successfully edited'
    else
      render :edit
    end
  end

  def destroy
    @ingredient.delete

    redirect_to ingredients_path, notice: 'Ingredient was successfully deleted'
  end

  private

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :amount, :amount_type, product_ids: [], purchase_ids: [])
  end
end
