class SalesController < ApplicationController
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
      flash[:notice] = "Sale was successfully created"
      redirect_to sales_path
    end
  end

private
  def sale_params
    params.require(:sale).permit(:amount, :description)
  end
end
