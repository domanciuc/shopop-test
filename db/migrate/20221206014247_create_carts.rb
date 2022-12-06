class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      	t.timestamps
    end

    add_reference :carts, :user, foreign_key: true, index: true
  end
end
