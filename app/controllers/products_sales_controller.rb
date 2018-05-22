class ProductsSalesController < ApplicationController
  before_action :set_product, only: :show

  def index
  end

  def show
    @product = Product.find(params[:id])
    @sales = Sale.sales_by(current_user)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
