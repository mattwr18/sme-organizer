# frozen_string_literal: true

class VendorsController < ApplicationController
  before_action :set_vendor, only: %i[edit update show destroy]

  def index
    @vendors = Vendor.vendors_by(current_user)
  end

  def show; end

  def new
    @vendor = Vendor.new
  end

  def edit; end

  def create
    @vendor = Vendor.new(vendor_params)
    @vendor.user_id = current_user.id

    if @vendor.save
      redirect_to @vendor, notice: 'Vendor was succesfully created'
    else
      render :new
    end
  end

  def update
    if @vendor.update(vendor_params)
      redirect_to @vendor, notice: 'Vendor was successfully edited'
    else
      render :edit
    end
  end

  def destroy
    @vendor.delete

    redirect_to vendors_path, notice: 'Vendor succesfully deleted'
  end

  private

  def set_vendor
    @vendor = Vendor.find(params[:id])
  end

  def vendor_params
    params.require(:vendor).permit(:name, :phone_number, :obs)
  end
end
