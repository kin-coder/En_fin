class CreateOrderServiceCategorySubcategories < ActiveRecord::Migration[6.0]
  def change
    create_table :order_service_category_subcategories do |t|
      t.belongs_to :subcategory
  	  t.belongs_to :order_service_category
  	  t.belongs_to :devis_prestation, index:true
  	  
      t.timestamps
    end
  end
end
