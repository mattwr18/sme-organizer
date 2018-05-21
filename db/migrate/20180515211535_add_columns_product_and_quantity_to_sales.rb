# frozen_string_literal: true

class AddColumnsProductAndQuantityToSales < ActiveRecord::Migration[5.2]
  def change
    add_column :sales, :product, :string
    add_column :sales, :quantity, :integer
  end
end
