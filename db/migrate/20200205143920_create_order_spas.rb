class CreateOrderSpas < ActiveRecord::Migration[6.0]
  def change
    create_table :order_spas do |t|
      t.string :logement
      t.string :installation
      t.string :syteme_eau
      t.belongs_to :order, index:true
      
      t.timestamps
    end
  end
end
