class HomepageController < ApplicationController
  def index
    @purchases = Purchase.all
    @sales = Sale.all
    @profit = @sales.sum(:amount) - @purchases.sum(:amount)
  end

  def profit_calc(sales, purchases)
    @purchases - @sales
  end
end
