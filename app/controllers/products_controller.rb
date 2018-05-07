# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update show destroy]

  def index
    @products = Product.products_by(current_user)
  end

  def show; end

  def new
    @product = Product.new
    @product.ingredients.build
  end

  def edit; end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id

    if @product.save
      redirect_to @product, notice: 'Product was successfully created'
    else
      render :new
    end
  end

  def update
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

  def product_params
    params.require(:product).permit(:name, ingredients_attributes: %i[name amount amount_type])
  end
end
