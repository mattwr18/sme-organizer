class SalesController < ApplicationController
  before_action :set_sale, only: [:edit, :update, :show, :destroy]

  def index
    @sales = Sale.all
  end

  def show
  end

  def new
    @sale = Sale.new
  end

  def edit
  end

  def create
    @sale = Sale.new(sale_params)

    if @sale.save
      redirect_to @sale, notice: "Sale was successfully created"
    end
  end

  def update
    if @sale.update(sale_params)
      redirect_to @sale, notice: "Sale was successfully edited"
    end
  end

  def destroy
    @sale.delete

    redirect_to sales_path, notice: "Sale was successfully deleted"
  end

private
  def set_sale
    @sale = Sale.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:amount, :description)
  end
end
