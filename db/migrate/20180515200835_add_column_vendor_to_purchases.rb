class AddColumnVendorToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :vendor, :string
  end
end
