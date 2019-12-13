class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :Datetime
      t.belongs_to :client, index:true
      t.belongs_to :service, index:true
      t.timestamps
    end
  end
end
