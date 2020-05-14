class CreateOrderSpas < ActiveRecord::Migration[6.0]
  def change
    create_table :order_spas do |t|
      t.string :logement
      t.string :installation
      t.string :syteme_eau

      t.belongs_to :order
      t.belongs_to :spa
      
      t.timestamps
    end
  end
end
