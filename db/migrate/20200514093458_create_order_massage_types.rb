class CreateOrderMassageTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :order_massage_types do |t|
    	t.belongs_to :order_massage
			t.belongs_to :massage_type
			t.belongs_to :massage_duration_price, index:true
			
      t.timestamps
    end
  end
end
