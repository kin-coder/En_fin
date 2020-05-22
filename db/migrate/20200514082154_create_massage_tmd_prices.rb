class CreateMassageTmdPrices < ActiveRecord::Migration[6.0]
  def change
    create_table :massage_tmd_prices do |t|
    	t.belongs_to :massage_type
			t.belongs_to :massage_duration_price
      t.timestamps
    end
  end
end
