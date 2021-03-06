# frozen_string_literal: true

# Control products flow
class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update show destroy]

  def index
    @products = Product.products_by(current_user)

    respond_to do |format|
      format.html
      format.json { render json: @products }
    end
  end

  def show; end

  def new
    @product = Product.new
    @product.ingredients.build
  end

  def edit; end

  def create
    @product = Product.new(product_params)
    set_user_id
    if @product.save
      redirect_to @product, notice: 'Product was successfully created'
    else
      render :new
    end
  end

  def update
    set_user_id
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully edited'
    else
      render :edit
    end
  end

  def destroy
    @product.delete

    redirect_to products_path, notice: 'Product was successfully deleted'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def set_user_id
    @product.user_id = current_user.id
    @product.ingredients.each do |ingredient|
      ingredient.user_id = current_user.id
    end
  end

  def product_params
    params.require(:product)
          .permit(:name, :price,
                  ingredients_attributes: %i[name amount amount_type id],
                  sale_ids: [], ingredient_ids: [])
  end
end
