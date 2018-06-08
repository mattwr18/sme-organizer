# frozen_string_literal: true

class AddColumnPriceToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :price, :float
  end
end
