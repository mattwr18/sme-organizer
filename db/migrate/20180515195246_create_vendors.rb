class CreateVendors < ActiveRecord::Migration[5.2]
  def change
    create_table :vendors do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :phone_number
      t.text :obs

      t.timestamps
    end
  end
end
