class ChangeColumnNameAmountToTotalPurchases < ActiveRecord::Migration[5.2]
  def change
    rename_column :purchases, :amount, :total
  end
end
