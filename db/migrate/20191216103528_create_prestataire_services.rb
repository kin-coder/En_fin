class CreatePrestataireServices < ActiveRecord::Migration[6.0]
  def change
    create_table :prestataire_services do |t|
      t.belongs_to :prestataire, index:true
      t.belongs_to :service, index:true
      
      t.timestamps
    end
  end
end
