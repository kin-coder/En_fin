class CreatePrestataireCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :prestataire_countries do |t|
    	t.belongs_to :country, index:true
      t.belongs_to :prestataire, index:true

      t.timestamps
    end
  end
end
