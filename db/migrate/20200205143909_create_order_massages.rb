class CreateOrderMassages < ActiveRecord::Migration[6.0]
  def change
    create_table :order_massages do |t|
      t.belongs_to :order
			t.belongs_to :massage

      t.timestamps
    end
  end
end
