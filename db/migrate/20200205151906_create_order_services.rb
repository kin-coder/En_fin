class CreateOrderServices < ActiveRecord::Migration[6.0]
  def change
    create_table :order_services do |t|
      t.string :service_time
      t.string :confirm_token
      #verifi si le commande est en cours traitée non traitée
      t.string :status_order, default:'en cours'

      t.belongs_to :order
      t.belongs_to :service
      
      t.belongs_to :prestataire

      t.timestamps
    end
  end
end
