class CreateOrderSubCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :order_sub_categories do |t|
      t.belongs_to :order_category, index:true
      t.belongs_to :subcategory, index:true
      t.timestamps
    end
  end
end
