class CreateOrderServiceCategorySpas < ActiveRecord::Migration[6.0]
  def change
    create_table :order_service_category_spas do |t|
      t.string :logement
      t.string :installation
      t.string :syteme_eau
      t.references :order_service_category
      t.timestamps
    end
  end
end
