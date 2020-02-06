class CreateOtherSuPrices < ActiveRecord::Migration[6.0]
  def change
    create_table :other_su_prices do |t|
      t.belongs_to :massage_su
  	  t.belongs_to :massage_su_price

      t.timestamps
    end
  end
end
