# frozen_string_literal: true

class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.float :amount
      t.text :description

      t.timestamps
    end
  end
end
