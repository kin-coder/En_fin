class CreatePrestataireOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :prestataire_orders do |t|

      t.timestamps
    end
  end
end
