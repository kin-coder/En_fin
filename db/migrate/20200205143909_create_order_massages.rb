class CreateOrderMassages < ActiveRecord::Migration[6.0]
  def change
    create_table :order_massages do |t|
      t.belongs_to :order, index:true
      t.belongs_to :massage_ca, index:true
      t.belongs_to :massage_su, index:true
      t.belongs_to :massage_su_price, index:true
      t.timestamps
    end
  end
end
