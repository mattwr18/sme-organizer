# frozen_string_literal: true

class HomepageController < ApplicationController
  def index
    @purchases = Purchase.purchases_by(current_user)
    @sales = Sale.sales_by(current_user)
    @profit = @sales.sum(:total) - @purchases.sum(:total)
  end

  def profit_calc(_sales, _purchases)
    @purchases - @sales
  end
end
