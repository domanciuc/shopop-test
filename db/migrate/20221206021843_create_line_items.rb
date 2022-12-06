class CreateLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :line_items do |t|
		t.integer :order_id
		t.integer :quantity, default: 1
		t.decimal :price, precision: 8, scale: 2
      t.timestamps
    end

    add_reference :line_items, :product, foreign_key: true, index: true
    add_reference :line_items, :cart, foreign_key: true, index: true
  end
end
