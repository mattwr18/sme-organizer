class AddColumnClientToSales < ActiveRecord::Migration[5.2]
  def change
    add_column :sales, :client, :string
  end
end
