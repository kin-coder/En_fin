class CreateOtherSuPrices < ActiveRecord::Migration[6.0]
  def change
    create_table :other_su_prices do |t|

      t.timestamps
    end
  end
end
