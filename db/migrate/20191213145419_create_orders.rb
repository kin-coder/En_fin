class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :datetime
      t.string :adresse 	#adresse de livraison
      t.text :description #question suplementaire au produits
      t.belongs_to :client, index:true
      t.belongs_to :service, index:true
      t.belongs_to :department, index:true

      t.timestamps
    end
  end
end
