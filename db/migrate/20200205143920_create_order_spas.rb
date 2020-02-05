class CreateOrderSpas < ActiveRecord::Migration[6.0]
  def change
    create_table :order_spas do |t|

      t.timestamps
    end
  end
end
