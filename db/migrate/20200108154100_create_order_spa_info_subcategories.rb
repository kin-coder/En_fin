class CreateOrderSpaInfoSubcategories < ActiveRecord::Migration[6.0]
  def change
    create_table :order_spa_info_subcategories do |t|
      t.string :logement
      t.string :installation
      t.string :systeme_eau
      t.belongs_to :order_sub_category, index:true
      
      t.timestamps
    end
  end
end
