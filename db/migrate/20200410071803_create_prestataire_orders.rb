class CreatePrestataireOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :prestataire_orders do |t|
      t.belongs_to :order, index:true
      t.belongs_to :prestataire, index:true
      t.boolean :accepted, default:false

      t.timestamps
    end
  end
end
