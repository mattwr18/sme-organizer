# frozen_string_literal: true

class AddColumnVendorToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :vendor, :string
  end
end
