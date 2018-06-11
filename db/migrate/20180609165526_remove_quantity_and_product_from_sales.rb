class RemoveQuantityAndProductFromSales < ActiveRecord::Migration[5.2]
  def change
    remove_column :sales, :quantity, :integer
    remove_column :sales, :product, :string
  end
end
