class CreateCandidates < ActiveRecord::Migration[6.0]
  def change
    create_table :candidates do |t|
      t.string :sexe
      t.string :first_name
      t.string :last_name
      t.string :date_of_birth
      t.string :raison_sociale
      t.string :siren
      t.string :email
      t.string :telephone
      t.string :adresse
      t.string :zip_code
      t.string :ville
      t.string :country
      t.string :services #spa | massage || coiffure
      t.string :countries #spa | France || Suisse
      t.string :departments #spa | Derap || Ain

      t.timestamps
    end
  end
end
