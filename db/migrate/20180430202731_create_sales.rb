class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.float :amount
      t.text :description

      t.timestamps
    end
  end
end
