class CreateOrderProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :order_products do |t|
      t.integer :number
      t.belongs_to :product, index:true
      t.belongs_to :order, index:true
      
      t.timestamps
    end
  end
end
