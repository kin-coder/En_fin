class CreateMassageSuPrices < ActiveRecord::Migration[6.0]
  def change
    create_table :massage_su_prices do |t|
      t.integer :duration
      t.float :exceptional_price
      t.float :ordinary_price
      t.float :exceptional_acompte
      t.float :ordinary_acompte

      t.timestamps
    end
  end
end
