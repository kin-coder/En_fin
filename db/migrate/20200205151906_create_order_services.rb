class CreateOrderServices < ActiveRecord::Migration[6.0]
  def change
    create_table :order_services do |t|
      t.belongs_to :order
      t.belongs_to :service
      t.string :service_time

      t.timestamps
    end
  end
end
