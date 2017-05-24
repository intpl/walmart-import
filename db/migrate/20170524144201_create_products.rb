class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :walmart_id
      t.integer :price
      t.string :name

      t.timestamps
    end

    add_index :products, :walmart_id, :unique => true
  end
end
