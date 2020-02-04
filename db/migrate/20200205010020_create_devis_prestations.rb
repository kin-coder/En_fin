class CreateDevisPrestations < ActiveRecord::Migration[6.0]
  def change
    create_table :devis_prestations do |t|
      t.integer :hours
      t.float :exceptional_price
      t.float :ordinary_price
      t.float :exceptional_acompte
      t.float :ordinary_acompte

      t.timestamps
    end
  end
end
