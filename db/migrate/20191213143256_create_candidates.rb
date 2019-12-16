class CreateCandidates < ActiveRecord::Migration[6.0]
  def change
    create_table :candidates do |t|
      t.string :first_name
      t.string :last_name
      t.string :adresse
      t.string :email
      t.string :telephone
      t.string :raison_sociale
      t.string :siret

      t.timestamps
    end
  end
end
