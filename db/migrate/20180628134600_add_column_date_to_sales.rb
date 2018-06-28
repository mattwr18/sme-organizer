class AddColumnDateToSales < ActiveRecord::Migration[5.2]
  def change
    add_column :sales, :date_of_sale, :date
  end
end
