class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :amount, null:false
      t.string  :customer_id, null:false
      t.boolean :is_success,      null:false, default: false
      t.timestamps null: false
    end
  end
end
