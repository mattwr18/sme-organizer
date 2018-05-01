class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:edit, :update, :show, :destroy]

  def index
    @purchases = Purchase.all
  end

  def show
  end

  def new
    @purchase = Purchase.new
  end

  def edit

  end

  def create
    @purchase = Purchase.new(purchase_params)

    if @purchase.save
      redirect_to purchase_path(@purchase), notice: "Purchase successfully created"
    end
  end

  def update
    if @purchase.update(purchase_params)
      redirect_to purchase_path(@purchase), notice: "Purchase has been successfully edited"
    end
  end

  def destroy
    @purchase.delete

    redirect_to purchases_path, notice: "Purchase has been succesfully deleted"
  end

private
  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  def purchase_params
    params.require(:purchase).permit(:amount, :description)
  end
end
