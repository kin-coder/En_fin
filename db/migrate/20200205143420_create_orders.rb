class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.date :prestation_date
      t.time :prestation_time
      t.string :billing_pays
      t.string :billing_ville
      t.string :billing_code_postal
      t.string :billing_adresse
      t.string :delivery_pays
      t.string :delivery_ville
      t.string :delivery_code_postal
      t.string :delivery_adresse
      t.string :praticien
      t.text :message
      t.belongs_to :client, index:true
      t.belongs_to :department, index:true

      t.timestamps
    end
  end
end
