class CreateOrderServiceCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :order_service_categories do |t|
	  t.belongs_to :category
	  t.belongs_to :order_service
      t.timestamps
    end
  end
end
