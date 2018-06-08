# frozen_string_literal: true

class ProductsSalesController < ApplicationController
  before_action :set_product, only: :show

  def index; end

  def show
    @product = Product.find(params[:id])
    @sales = Sale.sales_by(current_user)
  end

  def create
    binding.pry
    @product = Product.new(product_params)
    @product.user_id = current_user.id
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
