class AddColumnProductIdsToSales < ActiveRecord::Migration[5.2]
  def change
    add_column :sales, :product_ids, :text
  end
end
