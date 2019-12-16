class CreateOrderCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :order_categories do |t|
      t.belongs_to :category, index:true
      t.belongs_to :order, index:true
      t.timestamps
    end
  end
end
