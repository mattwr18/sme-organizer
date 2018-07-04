class ChangeColumnNameAmountToTotalSales < ActiveRecord::Migration[5.2]
  def change
    rename_column :sales, :amount, :total
  end
end
