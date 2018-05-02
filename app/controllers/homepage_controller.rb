class HomepageController < ApplicationController
  def index
    @purchases = Purchase.purchases_by(current_user)
    @sales = Sale.sales_by(current_user)
    @profit = @sales.sum(:amount) - @purchases.sum(:amount)
  end

  def profit_calc(sales, purchases)
    @purchases - @sales
  end
end
