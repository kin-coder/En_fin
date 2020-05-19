class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :prestation_date
      t.string :billing_pays
      t.string :billing_ville
      t.string :billing_code_postal
      t.string :billing_adresse
      t.string :billing_adresse_complet
      t.string :delivery_pays
      t.string :delivery_ville
      t.string :delivery_code_postal
      t.string :delivery_adresse
      t.string :delivery_adresse_complet
      t.string :praticien
      t.text :message
      t.boolean :is_validate, default:false #verifi si la commande est payer ou non
      #verifi si le commande est en cours traitée non traitée
      t.string :status_order, default:'en cours'

      t.belongs_to :client, index:true
      t.belongs_to :department, index:true
      t.belongs_to :country, index:true
      t.belongs_to :code_promo, index:true

      t.timestamps
    end
  end
end



# t.boolean :is_done, default:false #verifi si le commande est traité ou en cours
# t.boolean :is_validate, default:false #verifi si la commande est payer ou non
# t.boolean :is_canceled, default:false # command annulé par le client