class CreateOrderServiceCaSus < ActiveRecord::Migration[6.0]
  def change
    create_table :order_service_ca_sus do |t|
      t.belongs_to :subcategory
      t.belongs_to :order_service_ca
      t.belongs_to :devis_prestation, index:true
      
      t.timestamps
    end
  end
end
