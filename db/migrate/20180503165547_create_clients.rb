# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :address
      t.text :obs

      t.timestamps
    end
  end
end
