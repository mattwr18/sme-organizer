# frozen_string_literal: true

class CreateJoinTableProductsSales < ActiveRecord::Migration[5.2]
  def change
    create_join_table :products, :sales do |t|
      t.index %i[product_id sale_id]
      t.index %i[sale_id product_id]
    end
  end
end
