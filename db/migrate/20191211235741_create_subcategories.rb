class CreateSubcategories < ActiveRecord::Migration[6.0]
  def change
    create_table :subcategories do |t|
      t.string :name
      t.text :description
      t.float :price
      t.belongs_to :category, index:true
      
      t.timestamps
    end
  end
end
