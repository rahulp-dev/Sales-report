class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.decimal :amount
      t.string :customer_name

      t.timestamps
    end
  end
end
