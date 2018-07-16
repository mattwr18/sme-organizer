# frozen_string_literal: true

# Control purchases flow
class PurchasesController < ApplicationController
  before_action :set_purchase, only: %i[edit update show destroy]

  def index
    @purchases = Purchase.purchases_by(current_user).order(created_at: :desc)
  end

  def show; end

  def new
    @purchase = Purchase.new
    @purchase.ingredients.build
  end

  def edit; end

  def create
    @purchase = Purchase.new(purchase_params)
    set_user_id

    if @purchase.save
      redirect_to purchase_path(@purchase),
                  notice: 'Purchase successfully created'
    else
      render :new
    end
  end

  def update
    set_user_id
    if @purchase.update(purchase_params)
      redirect_to purchase_path(@purchase),
                  notice: 'Purchase has been successfully edited'
    else
      render :edit
    end
  end

  def destroy
    @purchase.delete

    redirect_to purchases_path, notice: 'Purchase has been succesfully deleted'
  end

  private

  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  def set_user_id
    @purchase.user_id = current_user.id
    @purchase.ingredients.each do |ingredient|
      ingredient.user_id = current_user.id
    end
  end

  def purchase_params
    params.require(:purchase)
          .permit(:total, :description, :vendor,
                  ingredients_attributes: %i[name amount amount_type id])
  end
end
