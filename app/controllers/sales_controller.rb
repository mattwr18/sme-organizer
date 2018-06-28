# frozen_string_literal: true

# Controls sales flow
class SalesController < ApplicationController
  before_action :set_sale, only: %i[edit update show destroy]

  def index
    @sales = Sale.sales_by(current_user).order(created_at: :desc)
                 .page(params[:page]).per(10)
  end

  def show; end

  def new
    @sale = Sale.new
    @products = Product.products_by(current_user)
    @clients = Client.clients_by(current_user)
  end

  def edit
    @products = Product.products_by(current_user)
  end

  def create
    @sale = Sale.new(sale_params)
    @sale_product_ids = params[:sale][:product_ids].split(',').map(&:to_i)
    @sale.product_ids = @sale_product_ids
    @sale.user_id = current_user.id

    if @sale.save
      redirect_to @sale, notice: 'Sale was successfully created'
    else
      render :new
    end
  end

  def update
    if @sale.update(sale_params)
      redirect_to @sale, notice: 'Sale was successfully edited'
    else
      render :edit
    end
  end

  def destroy
    @sale.delete

    redirect_to sales_path, notice: 'Sale was successfully deleted'
  end

  private

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:amount, :description, :client,
                                 :date_of_sale, product_ids: [])
  end
end
