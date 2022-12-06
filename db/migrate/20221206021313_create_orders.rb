class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
		t.string :name
		t.text :address
		t.string :email
		t.integer :pay_type
      	t.timestamps
    end

    add_reference :orders, :user, foreign_key: true, index: true
  end
end
