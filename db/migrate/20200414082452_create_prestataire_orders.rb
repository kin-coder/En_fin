class CreatePrestataireOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :prestataire_orders do |t|
      t.boolean :is_accepted, default:true
      t.belongs_to :order, index:true
      t.belongs_to :prestataire, index:true
      
      t.timestamps
    end
  end
end
